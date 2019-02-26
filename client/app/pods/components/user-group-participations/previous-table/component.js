import Component from '@ember/component';
import DestroyConfirmable from 'students-crm-v2/mixins/destroy-confirmable';

import { computed } from '@ember/object';
import { inject as service } from '@ember/service';
import { set } from '@ember/object';

export default Component.extend(DestroyConfirmable, {
  classNames: ['ember-table'],

  intl: service(),
  modalsManager: service(),

  groupParticipationToDestroy: null,
  destroyModalId: 'destroyGroupParticipation',

  onDestroySunccessToast: computed('intl.locale', function() {
    return this.intl.t('userGroupParticipations.destroyedSuccessfully');
  }),

  actions: {
    showDestroyConfirmation(groupParticipation) {
      set(this, 'groupParticipationToDestroy', groupParticipation);
      this.modalsManager.showModal(this.destroyModalId);
    },
  },
});
