import Controller from '@ember/controller';
import { computed, set, setProperties } from '@ember/object';
import { inject as service } from '@ember/service';
import fetch from 'fetch';
import config from 'students-crm-v2/config/environment';
import { task } from 'ember-concurrency';

export default Controller.extend({
  session: service(),

  isTokenExpiredStepShown: false,
  isUserNotFoundStepShown: false,
  loginMethod: '',
  loginToken: '',
  methodValue: '',
  registerPayload: null,

  loginMethodValueLabel: computed('loginMethod', function() {
    return `login.methodValueStep.value.${this.loginMethod}`;
  }),

  post(path, data) {
    const url = `${config.API_HOST}/${config.API_NAMESPACE}${path}`;

    return fetch(url, {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    })
  },

  generateLoginToken: task(function * (nextStep, loginMethod, methodValue) {
    yield this
      .post("/token-generate", { [loginMethod]: methodValue })
      .then(() => nextStep());
  }).drop(),

  registerUser: task(function * (registerPayload) {
    yield this
      .post("/token-register", registerPayload)
      .then(response => response.json())
      .then(({ loginToken }) => this.session.authenticate('authenticator:token', { loginToken }));
  }).drop(),

  verifyLoginToken: task(function * (loginToken, nextStep) {
    yield this
      .session
      .authenticate('authenticator:token', { loginToken })
      .catch(({ status, json }) => {
        switch (status) {
          case 404:
            setProperties(this, { isUserNotFoundStepShown: true, registerPayload: json });
            nextStep();

            break;
          case 498:
            set(this, 'isTokenExpiredStepShown', true);
            nextStep();

            break;
        }
      });
  }).drop(),

  actions: {
    selectLoginMethodAndNext(method, next) {
      set(this, 'loginMethod', method);

      next();
    },

    enterLoginTokenAgain(changeStep) {
      changeStep();

      set(this, 'isTokenExpiredStepShown', false);
    },

    resetSteps(goTo) {
      setProperties(this, {
        isTokenExpiredStepShown: false,
        isUserNotFoundStepShown: false,
        loginMethod: '',
        loginToken: '',
        methodValue: '',
        registerPayload: null,
      });

      goTo(0);
    },
  },
});
