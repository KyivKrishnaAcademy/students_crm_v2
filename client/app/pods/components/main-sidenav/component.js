import Component from '@ember/component';

import { inject as service } from "@ember/service";

export default Component.extend({
  tagName: '',

  i18n: service(),
  session: service(),
  sidebarOpenState: service(),

  actions: {
    invalidateSession() {
      this.get('session').invalidate();
    },
  },
});
