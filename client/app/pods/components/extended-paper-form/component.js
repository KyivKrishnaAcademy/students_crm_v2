import layout from './template';
import ParentForm from 'ember-paper/components/paper-form';

export default ParentForm.extend({
  layout,

  datePickerComponent: 'paper-pikaday',
});
