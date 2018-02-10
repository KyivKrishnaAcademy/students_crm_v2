import Base from 'ember-simple-auth-token/authenticators/jwt';

export default Base.extend({
  getAuthenticateData(credentials) {
    return { token: credentials };
  },
});
