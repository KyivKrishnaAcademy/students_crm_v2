import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render, find } from '@ember/test-helpers';
import hbs from 'htmlbars-inline-precompile';

module('Integration | Component | modals/base-modal', function(hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function(assert) {
    this.set('isShown', true);
    this.set('modalId', 'testModal');

    // Template block usage:
    await render(hbs`
      {{#modals/base-modal isShown=isShown modalId=modalId}}
        template block text
      {{/modals/base-modal}}
    `);

    let modalContent = find('#ember-testing > .md-dialog-container').textContent.trim();

    assert.equal(modalContent, 'template block text');
  });
});
