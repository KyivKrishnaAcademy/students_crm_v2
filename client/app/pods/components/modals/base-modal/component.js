import Component from '@ember/component';
import { inject as service } from '@ember/service';

export default Component.extend({
  modalsManager: service(),

  tagName: '',

  modalId: null,
  isShown: false,

  init() {
    this._super(...arguments);

    if (!this.modalId) return;

    this.modalsManager.on(`${this.modalId}-Show`, this, this.showModal);
    this.modalsManager.on(`${this.modalId}-Hide`, this, this.hideModal);
  },

  willDestroyElement() {
    this._super(...arguments);

    if (!this.modalId) return;

    this.modalsManager.off(`${this.modalId}-Show`, this, this.showModal);
    this.modalsManager.off(`${this.modalId}-Hide`, this, this.hideModal);
  },

  hideModal() {
    this.set('isShown', false);
  },

  showModal() {
    this.set('isShown', true);
  },

  actions: {
    onClose() {
      if (this.onClose) {
        this.onClose();
      } else {
        this.hideModal();
      }
    },
  },
});
