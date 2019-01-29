import { htmlSafe } from '@ember/string';
import { inject as service } from '@ember/service';
import { task } from 'ember-concurrency';

import Mixin from '@ember/object/mixin';

export default Mixin.create({
  intl: service(),
  modalsManager: service(),
  paperToaster: service(),

  destroyModalId: null,
  onSunccessToast: null,
  onSunccessCallback: null,

  concatErrors(acc, error) {
    if (error.status || error.title) {
      return `${acc}<br>${error.status || ''} ${error.title}`;
    } else if (error.detail) {
      return `${acc}<br>${error.detail}`;
    } else {
      return acc;
    }
  },

  destroyModel: task(function * (model) {
    try {
      yield model.destroyRecord();

      this.onSunccessToast && this.paperToaster.show(this.onSunccessToast);
      this.onSunccessCallback && this.onSunccessCallback();
    } catch(error) {
      let errorText = this.intl.t('errors.unknownServerError');

      error.errors.forEach(e => errorText = this.concatErrors(errorText, e));

      this.paperToaster.show(htmlSafe(errorText), { toastClass: 'md-warn', duration: 10000 });
    } finally {
      this.modalsManager.hideModal(this.destroyModalId);
    }
  }).drop(),

  actions: {
    showDestroyConfirmation() {
      this.modalsManager.showModal(this.destroyModalId);
    },
  },
});
