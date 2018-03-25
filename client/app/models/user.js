import attr from 'ember-data/attr';
import Model from 'ember-data/model';

import { modelAction } from 'ember-custom-actions';

export default Model.extend({
  displayName: attr('string'),
  locale: attr('string'),
  privacyAgreed: attr('boolean'),
  registered: attr('boolean'),

  agreeToPrivacyPolicy: modelAction('agree', { pushToStore: true }),
});
