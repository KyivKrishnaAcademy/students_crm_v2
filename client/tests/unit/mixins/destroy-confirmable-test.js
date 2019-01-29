import EmberObject from '@ember/object';
import DestroyConfirmableMixin from 'students-crm-v2/mixins/destroy-confirmable';
import { module, test } from 'qunit';

module('Unit | Mixin | destroy-confirmable', function() {
  // Replace this with your real tests.
  test('it works', function (assert) {
    let DestroyConfirmableObject = EmberObject.extend(DestroyConfirmableMixin);
    let subject = DestroyConfirmableObject.create();
    assert.ok(subject);
  });
});
