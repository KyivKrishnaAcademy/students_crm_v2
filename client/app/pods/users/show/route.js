import Route from '@ember/routing/route';
import { set } from '@ember/object';

export default Route.extend({
  setupController(controller, model) {
    this._super(controller, model);

    set(controller, 'model', {
      user: model,
      academicGroups: this.store.findAll('academic-group'),
    });
  },
});
