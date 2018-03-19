import Service, { inject as service } from '@ember/service';

import { resolve } from 'rsvp';

export default Service.extend({
  session: service(),
  store: service(),

  load() {
    if (!this.get('session.isAuthenticated')) return resolve();

    return this
      .get('store')
      .queryRecord('user', { me: true })
      .then(user => this.set('user', user));
  }
});
