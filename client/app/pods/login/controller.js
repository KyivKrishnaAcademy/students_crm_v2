import Controller from '@ember/controller';
import { computed, set } from '@ember/object';
import { inject as service } from '@ember/service';
import fetch from 'fetch';
import config from 'students-crm-v2/config/environment';
import { task } from 'ember-concurrency';

export default Controller.extend({
  session: service(),

  loginMethod: '',
  loginToken: '',
  mothodValue: '',

  loginMethodValueLabel: computed('loginMethod', function() {
    return `login.methodValueStep.value.${this.loginMethod}`;
  }),

  loginMethodValueLabelRequired: computed('loginMethod', function() {
    return `login.methodValueStep.required.${this.loginMethod}`;
  }),

  generateLoginToken: task(function * (nextStep, loginMethod, mothodValue) {
    const url = `${config.API_HOST}/${config.API_NAMESPACE}/token-generate`;

    yield fetch(url, {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ [loginMethod]: mothodValue })
    }).then(() => nextStep());
  }).drop(),

  verifyLoginToken: task(function * (loginToken) {
    yield this.session.authenticate('authenticator:token', { loginToken });
  }).drop(),

  actions: {
    selectLoginMethodAndNext(method, next) {
      set(this, 'loginMethod', method);

      next();
    },
  },
});
