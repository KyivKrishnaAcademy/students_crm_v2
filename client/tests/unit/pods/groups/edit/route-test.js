import { module, test } from 'qunit';
import { setupTest } from 'ember-qunit';

module('Unit | Route | groups/edit', function(hooks) {
  setupTest(hooks);

  test('it exists', function(assert) {
    let route = this.owner.lookup('route:groups/edit');
    assert.ok(route);
  });
});
