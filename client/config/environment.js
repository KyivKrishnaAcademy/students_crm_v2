'use strict';

module.exports = function(environment) {
  let ENV = {
    modulePrefix: 'students-crm-v2',
    podModulePrefix: 'students-crm-v2/pods',
    environment,
    rootURL: '/',
    locationType: 'auto',
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      },
      EXTEND_PROTOTYPES: {
        // Prevent Ember Data from overriding Date.parse.
        Date: false
      }
    },

    'ember-simple-auth': {
      authenticationRoute: 'login',
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    },

    API_HOST: process.env.API_HOST,
    API_NAMESPACE: process.env.API_NAMESPACE,

    i18n: {
      defaultLocale: 'uk',
    },

    moment: {
      includeLocales: ['uk'],
    },

    tenant: process.env.TENANT,
  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;

    ENV.API_HOST = 'http://api.localhost:4000';
    ENV.API_NAMESPACE = 'api/v1';
    ENV.tenant= 'kyiv';
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
    ENV.APP.autoboot = false;
  }

  if (environment === 'production') {
    // here you can enable a production-specific feature
  }

  ENV['ember-simple-auth-token'] = {
    serverTokenEndpoint: `${ENV.API_HOST}/api/v1/token-auth/`,
  };

  return ENV;
};
