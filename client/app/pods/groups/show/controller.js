import Controller from '@ember/controller';
import DestroyConfirmable from 'students-crm-v2/mixins/destroy-confirmable';

import { computed } from '@ember/object';
import { inject as service } from '@ember/service';

export default Controller.extend(DestroyConfirmable, {
  intl: service(),

  destroyModalId: 'destroyAcademicGroup',

  onDestroySunccessToast: computed('intl.locale', function() {
    return this.intl.t('groups.show.destroyedSuccessfully', { groupName: this.model.name, htmlSafe: true });
  }),

  onDestroyCallback() {
    this.transitionToRoute('groups.index');
  },
});
