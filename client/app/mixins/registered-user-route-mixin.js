import Mixin from '@ember/object/mixin';

import { inject as service } from '@ember/service';

export default Mixin.create({
  session: service(),
  currentUser: service(),

  routeIfNotRegistered: 'register',

  beforeModel() {
    if (this.get('session.isAuthenticated') && !this.get('currentUser.user.registered')) {
      this.transitionTo(this.routeIfNotRegistered);
    } else {
      return this._super(...arguments);
    }
  }
});
