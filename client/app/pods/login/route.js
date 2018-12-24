import Route from '@ember/routing/route';
import UnauthenticatedRouteMixin from 'ember-simple-auth/mixins/unauthenticated-route-mixin';
import { setProperties } from '@ember/object';

export default Route.extend(UnauthenticatedRouteMixin, {
  setupController(controller, model) {
    this._super(controller, model);

    // one way queryParams
    let urlParams = new URLSearchParams(window.location.search);
    let loginToken = urlParams.get('loginToken');

    if (loginToken) {
      setProperties(controller, { loginToken: loginToken, currentStep: 2 });
    }
  }
});
