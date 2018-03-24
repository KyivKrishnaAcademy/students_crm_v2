import EmberObject from '@ember/object';
import RegisteredUserRouteMixinMixin from 'students-crm-v2/mixins/registered-user-route-mixin';
import { module, test } from 'qunit';

module('Unit | Mixin | registered-user-route-mixin', function() {
  // Replace this with your real tests.
  test('it works', function (assert) {
    let RegisteredUserRouteMixinObject = EmberObject.extend(RegisteredUserRouteMixinMixin);
    let subject = RegisteredUserRouteMixinObject.create();
    assert.ok(subject);
  });
});
