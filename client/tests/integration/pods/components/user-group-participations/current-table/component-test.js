import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import { setupIntl } from 'ember-intl/test-support';
import hbs from 'htmlbars-inline-precompile';

module('Integration | Component | user-group-participations/current-table', function(hooks) {
  setupRenderingTest(hooks);
  setupIntl(hooks, 'uk');

  test('it renders', async function(assert) {
    // Set any properties with this.set('myProperty', 'value');
    // Handle any actions with this.set('myAction', function(val) { ... });

    await render(hbs`{{user-group-participations/current-table}}`);

    assert.equal(this.element.querySelectorAll('table').length, 1);
  });
});
