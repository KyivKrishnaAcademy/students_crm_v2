import Component from '@ember/component';

import { computed } from '@ember/object';

export default Component.extend({
  currentGroupParticipations: computed('user.groupParticipations.@each.leaveReason', function() {
    return this.user.groupParticipations.filter(gp => !gp.leaveReason);
  }),

  previousGroupParticipations: computed('user.groupParticipations.@each.leaveReason', function() {
    return this.user.groupParticipations.filter(gp => gp.leaveReason);
  }),
});
