import Controller from '@ember/controller';

import { map } from '@ember/object/computed';
import { computed } from '@ember/object';
import { inject as service } from '@ember/service';

export default Controller.extend({
  intl: service(),

  columns: computed('intl.locale', function() {
    return [
      {
        name: '#',
        valuePath: 'index',
      },
      {
        name: this.intl.t('users.tableHeader.name'),
        valuePath: 'complexName',
      },
    ];
  }),

  students: map('model.students', function(student, index) {
    return {
      index: index + 1,
      complexName: student,
    };
  }),
});
