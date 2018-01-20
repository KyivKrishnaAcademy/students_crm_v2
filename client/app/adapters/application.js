import config from 'students-crm-v2/config/environment';
import JSONAPIAdapter from 'ember-data/adapters/json-api';

export default JSONAPIAdapter.extend({
  host: config.API_HOST,
  namespace: 'api/v1',
});
