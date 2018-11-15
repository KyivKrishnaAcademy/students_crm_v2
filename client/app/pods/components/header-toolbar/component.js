import Component from '@ember/component';
import Togglable from 'students-crm-v2/mixins/togglable';

import { inject as service } from '@ember/service';

export default Component.extend(Togglable, {
  tagName: '',

  session: service(),
  sidebarOpenState: service(),
});
