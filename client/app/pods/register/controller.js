import Controller from '@ember/controller';

import { computed } from '@ember/object';

export default Controller.extend({
  isGeneralFormInvalid: false,

  selectedGender: computed('model.user.gender', function() {
    let selectedValue = this.get('model.user.gender');

    return this.model.genders.find(gender => gender.value === selectedValue);
  }),

  actions: {
    agreeToPrivacy(nextStep) {
      this.model.user.agreeToPrivacyPolicy().then(() => nextStep());
    },

    saveUser(nextStep) {
      this.model.user.save().then(() => nextStep());
    },

    generalFormValidityChange(isValid, isTouched, isInvalidAndTouched) {
      this.set('isGeneralFormInvalid', isInvalidAndTouched);
    },

    selectGender(gender) {
      this.set('model.user.gender', gender && gender.value);
    }
  },
});
