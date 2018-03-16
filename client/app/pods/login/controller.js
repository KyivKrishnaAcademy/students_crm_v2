import Controller from '@ember/controller';

export default Controller.extend({
  actions: {
    selectAndNext(method, nextStep) {
      this.set('loginMethod', method);
      nextStep();
    },
  },
});
