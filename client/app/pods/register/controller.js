import Controller from '@ember/controller';

import { computed } from '@ember/object';
import { task } from 'ember-concurrency';

export default Controller.extend({
  isGeneralFormInvalid: false,

  selectedGender: computed('model.user.gender', function() {
    let selectedValue = this.get('model.user.gender');

    return this.model.genders.find(gender => gender.value === selectedValue);
  }),

  agreeToPrivacy: task(function * (nextStep) {
    yield this.model.user.agreeToPrivacyPolicy();

    nextStep();
  }).drop(),

  generalInfoSubmit: task(function * (nextStep) {
    yield this.model.user.save();

    nextStep();
  }).drop(),

  actions: {
    generalFormValidityChange(isValid, isTouched, isInvalidAndTouched) {
      this.set('isGeneralFormInvalid', isInvalidAndTouched);
    },

    selectGender(gender) {
      this.set('model.user.gender', gender && gender.value);
    }
  },
});
