import Controller from '@ember/controller';
import {inject as service} from '@ember/service';

export default Controller.extend({
  modalsManager: service(),

  userDestroyModalId: 'destroyUser',

  actions: {
    showDestroyConfirmation() {
      this.modalsManager.showModal(this.userDestroyModalId);
    },

    destroyUser() {
    },
  },
});
