import attr from 'ember-data/attr';
import Model from 'ember-data/model';

import { belongsTo } from 'ember-data/relationships';
import { computed } from '@ember/object';
import { inject as service } from '@ember/service';
import { modelAction } from 'ember-custom-actions';

export default Model.extend({
  intl: service(),

  joinTime:attr('date'),
  leaveReason:attr('string'),
  leaveTime:attr('date'),

  leaveReasonIntl: computed('intl.locale', 'leaveReason', function() {
    return this.intl.t(`model.groupParticipations.leaveReason.${this.leaveReason}`);
  }),

  academicGroup: belongsTo(),
  user: belongsTo(),

  removeFromGroup: modelAction('remove_from_group', { pushToStore: true }),
});
