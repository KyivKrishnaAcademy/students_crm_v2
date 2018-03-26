import Route from '@ember/routing/route';

import { inject as service } from '@ember/service';

export default Route.extend({
  currentUser: service(),

  model() {
    let step = + this.get('currentUser.user.privacyAgreed');

    return {
      currentStep: step,
      user: this.get('currentUser.user'),
    };
  },
});
