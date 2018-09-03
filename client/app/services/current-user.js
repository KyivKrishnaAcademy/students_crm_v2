import { computed, get } from '@ember/object';
import { notEmpty } from '@ember/object/computed';
import { resolve } from 'rsvp';
import Service, { inject as service } from '@ember/service';

export default Service.extend({
  session: service(),
  store: service(),

  userId: null,

  isLoaded: notEmpty('userId'),

  user: computed('userId', function() {
    return this.store.peekRecord('user', this.userId || 0);
  }),

  load() {
    if (this.isLoaded || !get(this, 'session.isAuthenticated')) return resolve();

    return this
      .store
      .createRecord('session', {})
      .save()
      .then(session => this.set('userId', session.user.id));
  }
});
