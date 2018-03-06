import Component from '@ember/component';

import { inject as service } from "@ember/service";

export default Component.extend({
  tagName: '',

  session: service(),
  sidebarOpenState: service(),

  actions: {
    invalidateSession() {
      this.get('session').invalidate();
    },
  },
});
