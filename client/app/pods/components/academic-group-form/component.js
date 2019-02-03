import AdapterErrorToastable from 'students-crm-v2/mixins/adapter-error-toastable';
import Component from '@ember/component';
import { task } from 'ember-concurrency';

export default Component.extend(AdapterErrorToastable, {
  classNames: [
    'flex-xs',
    'flex-offset-gt-xs-10',
    'flex-gt-xs-80',
    'flex-offset-gt-sm-20',
    'flex-gt-sm-60',
    'flex-offset-gt-md-30',
    'flex-gt-md-40',
  ],

  onSubmit: task(function * (model) {
    try {
      yield model.save();

      this.onSunccessCallback && this.onSunccessCallback();
    } catch(error) {
      this.toastAdapterError(error);
    }
  }).drop(),
});
