import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';
import Route from '@ember/routing/route';
import RegisteredUserRouteMixin from 'students-crm-v2/mixins/registered-user-route-mixin';

export default Route.extend(AuthenticatedRouteMixin, RegisteredUserRouteMixin, {
});
