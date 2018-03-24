import Controller from '@ember/controller';

import { inject as service } from '@ember/service';

export default Controller.extend({
  currentUser: service(),

  actions: {
    agreeToPrivacy(nextStep) {
      this.get('currentUser.user').agreeToPrivacyPolicy().then(() => nextStep());
    },
  },
});
