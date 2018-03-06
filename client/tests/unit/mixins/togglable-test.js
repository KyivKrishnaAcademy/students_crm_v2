import EmberObject from '@ember/object';
import TogglableMixin from 'students-crm-v2/mixins/togglable';
import { module, test } from 'qunit';

module('Unit | Mixin | togglable', function() {
  // Replace this with your real tests.
  test('it works', function (assert) {
    let TogglableObject = EmberObject.extend(TogglableMixin);
    let subject = TogglableObject.create();
    assert.ok(subject);
  });
});
