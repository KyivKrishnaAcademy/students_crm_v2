import Controller from '@ember/controller';
import { map } from '@ember/object/computed';
import { computed } from '@ember/object';

export const controllerDefaults = {
  pageNumber: 1,
  pageSize: 3,
};

export default Controller.extend(controllerDefaults, {
  queryParams: ['pageNumber', 'pageSize'],

  init() {
    this._super(...arguments);
    this.columns = [
      {
        name: '#',
        valuePath: 'index',
      },
      {
        name: 'name',
        valuePath: 'complexName',
      },
    ];
  },

  indexOffset: computed('pageNumber', 'pageSize', function() {
    return (this.pageNumber - 1) * this.pageSize + 1;
  }),

  users: map('model', function(user, index) {
    let { complexName } = user;

    return {
      complexName,
      index: this.indexOffset + index,
    };
  }),
});
