import Route from '@ember/routing/route';
import moment from 'moment';

export default Route.extend({
  model() {
    return this.store.createRecord('academic_group', {
      establishedOn: moment().format('YYYY-MM-DD'),
    });
  },
});
