import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import { setupIntl } from 'ember-intl/test-support';
import hbs from 'htmlbars-inline-precompile';

module('Integration | Component | user-group-participations', function(hooks) {
  setupRenderingTest(hooks);
  setupIntl(hooks, 'uk');

  test('it renders', async function(assert) {
    this.set('user', { groupParticipations: [] });

    await render(hbs`{{user-group-participations user=user}}`);

    assert.equal(this.element.querySelectorAll('table').length, 2);
  });
});
