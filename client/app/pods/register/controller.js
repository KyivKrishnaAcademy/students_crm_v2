import Controller from '@ember/controller';

import config from 'students-crm-v2/config/environment';
import { computed, get } from '@ember/object';
import { task } from 'ember-concurrency';
import { inject as service } from '@ember/service';

export default Controller.extend({
  session: service(),

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

  uploadFile: task(function * (file, kind) {
    const { API_HOST, API_NAMESPACE } = config;
    const accessToken = get(this, 'session.data.authenticated.accessToken');

    yield file.upload(`${API_HOST}/${API_NAMESPACE}/documents`, {
      data: { kind },
      headers: { Authorization: `Bearer ${accessToken}` },
    });
  }).drop(),

  actions: {
    generalFormValidityChange(isValid, isTouched, isInvalidAndTouched) {
      this.set('isGeneralFormInvalid', isInvalidAndTouched);
    },

    selectGender(gender) {
      this.set('model.user.gender', gender && gender.value);
    },

    uploadIdentificationDocument(file) {
      get(this, 'uploadFile').perform(file, 'identification');
    },
  },
});
