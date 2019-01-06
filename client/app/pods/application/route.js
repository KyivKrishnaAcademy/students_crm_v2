import Route from '@ember/routing/route';
import ApplicationRouteMixin from 'ember-simple-auth/mixins/application-route-mixin';

import { inject as service } from '@ember/service';

export default Route.extend(ApplicationRouteMixin, {
  currentUser: service(),
  moment: service(),

  beforeModel() {
    this.moment.setLocale('uk');
    this._super(...arguments);

    return this.currentUser.load();
  },

  sessionAuthenticated() {
    this.currentUser.load();
    this._super(...arguments);
  },
});
