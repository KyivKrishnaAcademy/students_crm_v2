import Route from '@ember/routing/route';

import { inject as service } from '@ember/service';

export default Route.extend({
  currentUser: service(),

  setupController(controller, model) {
    this._super(controller, model);

    let step = + this.get('currentUser.user.privacyAgreed');

    controller.set('currentStep', step);
  }
});
