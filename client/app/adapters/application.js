import config from 'students-crm-v2/config/environment';
import JSONAPIAdapter from 'ember-data/adapters/json-api';
import TokenAuthorizerMixin from 'ember-simple-auth-token/mixins/token-authorizer';

export default JSONAPIAdapter.extend(TokenAuthorizerMixin, {
  host: config.API_HOST,
  namespace: config.API_NAMESPACE,
});
