import Route from '@ember/routing/route';

import { inject as service } from '@ember/service';

export default Route.extend({
  currentUser: service(),
  intl: service(),

  beforeModel() {
    return this.currentUser.load();
  },

  model() {
    let step = + this.get('currentUser.user.privacyAgreed');
    let optionMapper = (key, subkey) => ({ value: subkey, label: this.intl.t(`register.generalInfo.${key}.${subkey}`) });
    let genderOptionMapper = subkey => optionMapper('gender', subkey);
    let maritalStatusOptionMapper = subkey => optionMapper('maritalStatus', subkey);

    return {
      currentStep: step,
      user: this.get('currentUser.user'),
      genders: ['female', 'male'].map(genderOptionMapper),
      maritalStatuses: ['single', 'in_relationship', 'married', 'divorced', 'widowed'].map(maritalStatusOptionMapper),
    };
  },
});
