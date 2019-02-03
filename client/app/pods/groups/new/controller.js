import Controller from '@ember/controller';

export default Controller.extend({
  actions: {
    onSunccessTransition(model) {
      this.transitionToRoute('groups.show', model);
    },
  },
});
