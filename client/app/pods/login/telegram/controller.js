import config from 'students-crm-v2/config/environment';
import Controller from '@ember/controller';

import { inject as service } from "@ember/service";

const { TELEGRAM_BOT, TELEGRAM_LINK } = config;

export default Controller.extend({
  TELEGRAM_BOT,
  TELEGRAM_LINK,

  token: '',
  errorMessage: '',

  session: service(),

  actions: {
    authenticate(token) {
      this.get('session').authenticate('authenticator:pswdls-jwt', token).catch(reason => {
        this.set('errorMessage', reason.error || reason);
      });
    },
  },
});
