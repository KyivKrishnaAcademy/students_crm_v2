import Controller from '@ember/controller';
import { map } from '@ember/object/computed';
import { computed } from '@ember/object';
import { inject as service } from '@ember/service';

export const controllerDefaults = {
  pageNumber: 1,
  pageSize: 50,
};

export default Controller.extend(controllerDefaults, {
  intl: service(),

  queryParams: ['pageNumber', 'pageSize'],

  columns: computed('intl.locale', function() {
    return [
      {
        name: '#',
        valuePath: 'index',
      },
      {
        name: this.intl.t('groups.tableHeader.name'),
        valuePath: 'name',
      },
    ];
  }),

  indexOffset: computed('pageNumber', 'pageSize', function() {
    return (this.pageNumber - 1) * this.pageSize + 1;
  }),

  users: map('model', function(group, index) {
    return {
      index: this.indexOffset + index,
      name: group,
    };
  }),
});
