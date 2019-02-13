import Controller from '@ember/controller';
import DestroyConfirmable from 'students-crm-v2/mixins/destroy-confirmable';

import { inject as service } from "@ember/service";

export default Controller.extend(DestroyConfirmable, {
  session: service(),

  destroyModalId: 'destroyCurrentUser',

  onDestroyCallback() {
    this.session.invalidate();
  },
});
