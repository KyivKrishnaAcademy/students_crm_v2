import Controller from '@ember/controller';
import DestroyConfirmable from 'students-crm-v2/mixins/destroy-confirmable';

import { computed } from '@ember/object';
import { inject as service } from '@ember/service';
import { get, set } from '@ember/object';
import { task } from 'ember-concurrency';

export default Controller.extend(DestroyConfirmable, {
  intl: service(),

  selectedGroupOption: null,

  destroyModalId: 'destroyUser',
  addToGroupModalId: 'addToGroup',

  onDestroySunccessToast: computed('intl.locale', function() {
    return this.intl.t('users.show.destroyedSuccessfully');
  }),

  onAddToGroupSunccessToast: computed('intl.locale', 'selectedGroupOption.name', function() {
    return this.intl.t('users.show.addedToGroupSuccessfully', {
      htmlSafe: true,
      groupName: this.selectedGroupOption.name,
      userName: this.model.user.complexName,
    });
  }),

  groupsOptions: computed(
    'model.academicGroups.{isPending,isFulfilled}',
    'model.user.groupParticipations.{isPending,isFulfilled,@each.leaveTime}',
    function() {
      let isReady =
        !this.model.academicGroups.isPending &&
        this.model.academicGroups.isFulfilled &&
        !this.model.user.groupParticipations.isPending &&
        this.model.user.groupParticipations.isFulfilled;

      if (!isReady) return [];

      let activeGroupIds = this
        .model
        .user
        .groupParticipations
        .filter(gp => !gp.leaveTime)
        .map(gp => get(gp.academicGroup, 'id'));

      return this.model.academicGroups.map(
        group => ({ name: group.name, group: group, disabled: activeGroupIds.indexOf(get(group, 'id')) >= 0 })
      );
    }
  ),

  onDestroyCallback() {
    this.transitionToRoute('users');
  },

  addToGroup: task(function * (selectedOption) {
    try {
      yield this
        .store
        .createRecord('group-participation', { user: this.model.user, academicGroup: selectedOption.group})
        .save();

      this.onDestroySunccessToast && this.paperToaster.show(this.onAddToGroupSunccessToast);
    } catch(error) {
      this.toastAdapterError(error);
    } finally {
      this.modalsManager.hideModal(this.addToGroupModalId);
    }
  }).drop(),

  actions: {
    showAddToGroupConfirmation(selectedOption) {
      set(this, 'selectedGroupOption', selectedOption);
      this.modalsManager.showModal(this.addToGroupModalId);
    },
  },
});
