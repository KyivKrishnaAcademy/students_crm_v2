import config from 'students-crm-v2/config/environment';
import JSONAPIAdapter from 'ember-data/adapters/json-api';
import DataAdapterMixin from 'ember-simple-auth/mixins/data-adapter-mixin';

import { get } from '@ember/object';
import { isPresent } from '@ember/utils';

export default JSONAPIAdapter.extend(DataAdapterMixin, {
  host: config.API_HOST,
  namespace: config.API_NAMESPACE,
  tokenAttribute: 'accessToken',

  authorize(xhr) {
    let token = get(this, `session.data.authenticated.${this.tokenAttribute}`);

    if (isPresent(token)) xhr.setRequestHeader('Authorization', `Bearer ${token}`);
  },
});
