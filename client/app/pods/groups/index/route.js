import Route from '@ember/routing/route';
import { setProperties } from '@ember/object';
import { controllerDefaults } from './controller';

export default Route.extend({
  queryParams: {
    pageNumber: { refreshModel: true },
    pageSize: { refreshModel: true },
  },

  model(params) {
    return this.store.query('academic_group', {
      page: {
        number: params.pageNumber,
        size: params.pageSize,
      }
    });
  },

  resetController(controller, isExiting) {
    if (isExiting) setProperties(controller, controllerDefaults);

    this._super(...arguments);
  },
});
