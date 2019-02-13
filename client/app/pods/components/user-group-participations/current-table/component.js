import Component from '@ember/component';
import AdapterErrorToastable from 'students-crm-v2/mixins/adapter-error-toastable';

import { inject as service } from '@ember/service';
import { task } from 'ember-concurrency';
import { set } from '@ember/object';

export default Component.extend(AdapterErrorToastable, {
  classNames: ['ember-table'],

  modalsManager: service(),

  groupParticipationToRemoveFromGroup: null,
  removeFromGroupModalId: 'removeFromGroup',

  removeFromGroup: task(function * (groupParticipation) {
    try {
      yield groupParticipation.removeFromGroup();
    } catch(error) {
      this.toastAdapterError(error);
    } finally {
      this.modalsManager.hideModal(this.removeFromGroupModalId);
    }
  }).drop(),

  actions: {
    showRemoveFromGroupConfirmation(groupParticipation) {
      set(this, 'groupParticipationToRemoveFromGroup', groupParticipation);
      this.modalsManager.showModal(this.removeFromGroupModalId);
    },
  },
});
