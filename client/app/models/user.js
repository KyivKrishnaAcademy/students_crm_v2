import attr from 'ember-data/attr';
import Model from 'ember-data/model';
import moment from 'moment';

import { modelAction } from 'ember-custom-actions';
import { validator, buildValidations } from 'ember-cp-validations';

const Validations = buildValidations({
  birthday: validator('date', {
    before: moment().subtract(10, 'years').format('YYYY-MM-DD'),
    descriptionKey: 'register.generalInfo.birthday',
    format: 'YYYY-MM-DD',
  }),
});

export default Model.extend(Validations, {
  birthday: attr('string'),
  displayName: attr('string'),
  gender: attr('string'),
  locale: attr('string'),
  privacyAgreed: attr('boolean'),
  registered: attr('boolean'),

  agreeToPrivacyPolicy: modelAction('agree', { pushToStore: true }),
});
