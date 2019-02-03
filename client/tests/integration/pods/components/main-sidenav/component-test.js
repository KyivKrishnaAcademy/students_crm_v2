import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import { setupIntl } from 'ember-intl/test-support';
import hbs from 'htmlbars-inline-precompile';

module('Integration | Component | main-sidenav', function(hooks) {
  setupRenderingTest(hooks);
  setupIntl(hooks, 'uk');

  test('it renders', async function(assert) {
    // Set any properties with this.set('myProperty', 'value');
    // Handle any actions with this.set('myAction', function(val) { ... });

    await render(hbs`{{main-sidenav}}`);

    let content = 'homeДомашняschoolГрупиpeopleЛюдиЗгоданаобробкуперсональнихданих';

    assert.equal(this.element.textContent.trim().replace(/\s+/g, ''), content);
  });
});
