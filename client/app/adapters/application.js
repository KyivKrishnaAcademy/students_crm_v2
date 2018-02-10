import config from 'students-crm-v2/config/environment';
import JSONAPIAdapter from 'ember-data/adapters/json-api';
import DataAdapterMixin from 'ember-simple-auth/mixins/data-adapter-mixin';

export default JSONAPIAdapter.extend(DataAdapterMixin, {
  host: config.API_HOST,
  namespace: config.API_NAMESPACE,
  authorizer: 'authorizer:token',
});
