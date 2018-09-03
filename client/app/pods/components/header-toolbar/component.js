import Component from '@ember/component';
import config from 'students-crm-v2/config/environment';
import Togglable from 'students-crm-v2/mixins/togglable';

import { inject as service } from '@ember/service';

export default Component.extend(Togglable, {
  tagName: '',

  i18n: service(),
  session: service(),
  sidebarOpenState: service(),

  actions: {
    login() {
      this.session.authenticate('authenticator:auth0-lock-passwordless', config.lockOptions);
    },
  },
});
