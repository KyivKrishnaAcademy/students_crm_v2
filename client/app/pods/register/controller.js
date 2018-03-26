import Controller from '@ember/controller';

export default Controller.extend({
  isInvalid: false,

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
  },
});
