import config from 'students-crm-v2/config/environment';
import JSONAPIAdapter from 'ember-data/adapters/json-api';
import TokenAuthorizerMixin from 'ember-simple-auth-token/mixins/token-authorizer';
import { underscore } from '@ember/string';
import { pluralize } from 'ember-inflector';

export default JSONAPIAdapter.extend(TokenAuthorizerMixin, {
  host: config.API_HOST,
  namespace: config.API_NAMESPACE,

  pathForType(type) {
    return underscore(pluralize(type));
  },

  authorize(xhr) {
    this._super(...arguments);

    xhr.setRequestHeader('Tenant', config.tenant);
  },
});
