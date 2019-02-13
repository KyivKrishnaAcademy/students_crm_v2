import Controller from '@ember/controller';
import DestroyConfirmable from 'students-crm-v2/mixins/destroy-confirmable';

import { computed } from '@ember/object';
import { inject as service } from '@ember/service';
import { set } from '@ember/object';
import { task } from 'ember-concurrency';

export default Controller.extend(DestroyConfirmable, {
  intl: service(),

  selectedGroup: null,

  destroyModalId: 'destroyUser',
  addToGroupModalId: 'addToGroup',

  onDestroySunccessToast: computed('intl.locale', function() {
    return this.intl.t('users.show.destroyedSuccessfully');
  }),

  onAddToGroupSunccessToast: computed('intl.locale', 'selectedGroup.name', function() {
    return this.intl.t('users.show.addedToGroupSuccessfully', {
      htmlSafe: true,
      groupName: this.selectedGroup.name,
      userName: this.model.user.complexName,
    });
  }),

  groupsOptions: computed('model.academicGroups.{isPending,isFulfilled}', function() {
    let isReady = this.model.academicGroups.isPending && this.model.academicGroups.isFulfilled;

    if (isReady) return this.model.academicGroups.map(group => ({ name: group.name, group: group }));

    return [];
  }),

  onDestroyCallback() {
    this.transitionToRoute('users');
  },

  addToGroup: task(function * (selectedOption) {
    try {
      yield this
        .store
        .createRecord('group-participation', { user: this.model.user, academicGroup: selectedOption})
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
      set(this, 'selectedGroup', selectedOption);
      this.modalsManager.showModal(this.addToGroupModalId);
    },
  },
});
