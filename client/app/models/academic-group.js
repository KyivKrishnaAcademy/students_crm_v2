import attr from 'ember-data/attr';
import Model from 'ember-data/model';

import { hasMany } from 'ember-data/relationships';
import { validator, buildValidations } from 'ember-cp-validations';

const Validations = buildValidations({
  name: validator('ds-error'),
  description: validator('ds-error'),
  establishedOn: validator('ds-error'),
});

export default Model.extend(Validations, {
  name: attr('string', { defaultValue: '' }),
  description: attr('string', { defaultValue: '' }),
  establishedOn: attr('string', { defaultValue: '' }),

  students: hasMany('users'),
});
