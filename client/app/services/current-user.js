import { computed, get } from '@ember/object';
import { notEmpty } from '@ember/object/computed';
import Service, { inject as service } from '@ember/service';
import { task } from 'ember-concurrency';

export default Service.extend({
  session: service(),
  store: service(),

  userId: null,

  isLoaded: notEmpty('userId'),

  user: computed('userId', function() {
    return this.store.peekRecord('user', this.userId || 0);
  }),

  loadUserTask: task(function * () {
    if (this.isLoaded || !get(this, 'session.isAuthenticated')) return yield this.user;

    try {
      let session = yield this.store.createRecord('session', {}).save();

      yield this.set('userId', session.user.id);

      return session.user;
    } catch(e) {
      return this.session.invalidate();
    }
  }).enqueue(),

  load() {
    return this.loadUserTask.perform();
  },
});
