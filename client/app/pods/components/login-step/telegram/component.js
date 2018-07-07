import config from 'students-crm-v2/config/environment';
import Component from '@ember/component';

import { computed } from '@ember/object';
import { inject as service } from "@ember/service";

const { TELEGRAM_BOT, TELEGRAM_LINK } = config;


export default Component.extend({
  TELEGRAM_BOT,
  TELEGRAM_LINK,

  tagName: '',

  token: '',
  isInvalidToken: false,
  isTokenTouched: false,

  i18n: service(),
  session: service(),

  init() {
    this._super(...arguments);
    this.errorMessages = [];
  },

  translatedErrors: computed('errorMessages', function() {
    if (!this.errorMessages.length) return this.errorMessages;

    return this.errorMessages.map(message => {
      let translated = this.i18n.t(`login-step/telegram.${message}`);

      return translated.string ? translated.string : message;
    });
  }),

  actions: {
    authenticate(token) {
      this.session.authenticate('authenticator:pswdls-jwt', token).catch(reason => {
        this.setProperties({
          errorMessages: [reason.error || reason],
          isInvalidToken: true,
          isTokenTouched: true,
        });
      });
    },
  },
});

