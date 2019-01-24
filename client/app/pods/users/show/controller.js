import Controller from '@ember/controller';
import {inject as service} from '@ember/service';
import { task } from 'ember-concurrency';
import { htmlSafe } from '@ember/string';

export default Controller.extend({
  intl: service(),
  modalsManager: service(),
  paperToaster: service(),

  userDestroyModalId: 'destroyUser',

  concatErrors(acc, error) {
    if (error.status || error.title) {
      return `${acc}<br>${error.status || ''} ${error.title}`;
    } else if (error.detail) {
      return `${acc}<br>${error.detail}`;
    } else {
      return acc;
    }
  },

  destroyUser: task(function * (user) {
    try {
      yield user.destroyRecord();

      this.paperToaster.show(this.intl.t('users.show.destroyedSuccessfully'));
      this.transitionToRoute('users');
    } catch(error) {
      let errorText = this.intl.t('errors.unknownServerError');

      error.errors.forEach(e => errorText = this.concatErrors(errorText, e));

      this.paperToaster.show(htmlSafe(errorText), { toastClass: 'md-warn', duration: 10000 });
    } finally {
      this.modalsManager.hideModal(this.userDestroyModalId);
    }
  }).drop(),

  actions: {
    showDestroyConfirmation() {
      this.modalsManager.showModal(this.userDestroyModalId);
    },
  },
});
