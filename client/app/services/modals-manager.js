import Service from '@ember/service';
import Evented from '@ember/object/evented';

export default Service.extend(Evented, {
  hideModal(modalId) {
    this.trigger(`${modalId}-Hide`);
  },

  showModal(modalId) {
    this.trigger(`${modalId}-Show`);
  },
});
