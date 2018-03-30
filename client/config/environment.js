'use strict';

const browsers = require('./targets');

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

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    },

    API_HOST: process.env.API_HOST,
    API_NAMESPACE: process.env.API_NAMESPACE,

    TELEGRAM_BOT: 'KrishnaAcademyBot',
    TELEGRAM_LINK: 'https://telegram.me/',

    autoprefixer: browsers,

    i18n: {
      defaultLocale: 'uk',
    },

    moment: {
      includeLocales: ['uk'],
    },
  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;

    ENV.API_HOST = 'http://api.localhost:4000';
    ENV.API_NAMESPACE = 'api/v1';
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
    tokenPropertyName: 'auth_token',
    serverTokenEndpoint: `${ENV.API_HOST}/${ENV.API_NAMESPACE}/login`,
    refreshTokenPropertyName: 'auth_token',
  };

  return ENV;
};
