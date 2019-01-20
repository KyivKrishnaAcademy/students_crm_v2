import Route from '@ember/routing/route';
import RegisteredUserRouteMixin from 'students-crm-v2/mixins/registered-user-route-mixin';

import { inject as service } from '@ember/service';

export default Route.extend(RegisteredUserRouteMixin, {
  currentUser: service(),

  model() {
    return this.currentUser.user;
  },
});
