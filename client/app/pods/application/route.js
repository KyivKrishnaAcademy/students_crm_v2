import Route from '@ember/routing/route';
import ApplicationRouteMixin from 'ember-simple-auth-auth0/mixins/application-route-mixin';

import { inject as service } from '@ember/service';

export default Route.extend(ApplicationRouteMixin, {
  currentUser: service(),
  moment: service(),

  beforeModel() {
    this.moment.setLocale('uk');
    this._loadCurrentUser();
    this._super(...arguments);
  },

  sessionAuthenticated() {
    this._loadCurrentUser();
    this._super(...arguments);
  },

  _loadCurrentUser() {
    return this.currentUser
      .load()
      .catch(() => this.session.invalidate());
  },
});
