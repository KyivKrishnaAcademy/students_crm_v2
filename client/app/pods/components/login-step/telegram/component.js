import config from 'students-crm-v2/config/environment';
import Component from '@ember/component';

import { inject as service } from "@ember/service";

const { TELEGRAM_BOT, TELEGRAM_LINK } = config;

export default Component.extend({
  TELEGRAM_BOT,
  TELEGRAM_LINK,

  token: '',
  tagName: '',
  session: service(),

  actions: {
    authenticate(token) {
      this.get('session').authenticate('authenticator:pswdls-jwt', token).catch(reason => {
        this.set('errorMessage', reason.error || reason);
      });
    },
  },
});

