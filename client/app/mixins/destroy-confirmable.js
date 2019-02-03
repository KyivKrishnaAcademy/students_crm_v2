import AdapterErrorToastable from 'students-crm-v2/mixins/adapter-error-toastable';
import { inject as service } from '@ember/service';
import { task } from 'ember-concurrency';

import Mixin from '@ember/object/mixin';

export default Mixin.create(AdapterErrorToastable, {
  modalsManager: service(),
  paperToaster: service(),

  destroyModalId: null,
  onSunccessToast: null,
  onSunccessCallback: null,

  destroyModel: task(function * (model) {
    try {
      yield model.destroyRecord();

      this.onSunccessToast && this.paperToaster.show(this.onSunccessToast);
      this.onSunccessCallback && this.onSunccessCallback();
    } catch(error) {
      this.toastAdapterError(error);
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
