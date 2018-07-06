import attr from 'ember-data/attr';
import Model from 'ember-data/model';

import { belongsTo } from 'ember-data/relationships';

export default Model.extend({
  assetUrl: attr('string'),
  kind: attr('string'),

  user: belongsTo('user'),
});
