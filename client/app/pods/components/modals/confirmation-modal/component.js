import Component from '@ember/component';
import { inject as service } from '@ember/service';

export default Component.extend({
  tagName: '',
  title: '',
  content: '',

  modalsManager: service(),

  actions: {
    onCancel() {
      this.modalsManager.hideModal(this.modalId);
    },
  },
});
