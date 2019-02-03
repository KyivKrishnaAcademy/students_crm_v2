import EmberObject from '@ember/object';
import AdapterErrorToastableMixin from 'students-crm-v2/mixins/adapter-error-toastable';
import { module, test } from 'qunit';

module('Unit | Mixin | adapter-error-toastable', function() {
  // Replace this with your real tests.
  test('it works', function (assert) {
    let AdapterErrorToastableObject = EmberObject.extend(AdapterErrorToastableMixin);
    let subject = AdapterErrorToastableObject.create();
    assert.ok(subject);
  });
});
