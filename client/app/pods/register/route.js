import Route from '@ember/routing/route';

import { inject as service } from '@ember/service';
import { translationMacro as t } from "ember-i18n";

export default Route.extend({
  currentUser: service(),
  i18n: service(),

  female: t('register.generalInfo.gender.female'),
  male: t('register.generalInfo.gender.male'),

  model() {
    let step = + this.get('currentUser.user.privacyAgreed');

    return {
      currentStep: step,
      user: this.get('currentUser.user'),
      genders: [
        { value: 'female', label: this.get('female') },
        { value: 'male', label: this.get('male') },
      ],
    };
  },
});
