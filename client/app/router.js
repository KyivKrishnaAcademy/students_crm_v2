import EmberRouter from '@ember/routing/router';
import config from './config/environment';

const Router = EmberRouter.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('users', function() {
    this.route('show', { path: '/:user_id' });
  });
  this.route('login');
  this.route('privacy');
  this.route('register');
  this.route('groups', function() {
    this.route('new');
    this.route('show', { path: '/:academic_group_id' }, function() {
      this.route('list');
    });
    this.route('edit', { path: '/:academic_group_id/edit' });
  });
});

export default Router;
