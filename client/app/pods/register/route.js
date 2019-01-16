import Route from '@ember/routing/route';

import { inject as service } from '@ember/service';
import { translationMacro as t } from 'ember-intl';

export default Route.extend({
  currentUser: service(),
  intl: service(),

  female: t('register.generalInfo.gender.female'),
  male: t('register.generalInfo.gender.male'),

  beforeModel() {
    return this.currentUser.load();
  },

  model() {
    let step = + this.get('currentUser.user.privacyAgreed');

    return {
      currentStep: step,
      user: this.get('currentUser.user'),
      genders: [
        { value: 'female', label: this.female },
        { value: 'male', label: this.male },
      ],
    };
  },
});
