import Controller from '@ember/controller';

import { computed } from '@ember/object';

export default Controller.extend({
  isInvalid: false,

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

    validityChange(isValid, isTouched, isInvalidAndTouched) {
      this.set('isInvalid', isInvalidAndTouched);
    },

    selectGender(gender) {
      this.set('model.user.gender', gender && gender.value);
    }
  },
});
