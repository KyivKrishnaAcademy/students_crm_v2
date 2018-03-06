import Mixin from '@ember/object/mixin';

export default Mixin.create({
  actions: {
    toggle(param) {
      this.set(param, !this.get(param));
    },
  },
});
