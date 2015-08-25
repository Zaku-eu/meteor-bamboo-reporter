Package.describe({
  name: 'zaku-eu:bamboo-reporter',
  version: '0.0.1',
  summary: 'A bamboo reporter for Velocity',
  git: 'https://github.com/zaku-eu/meteor-bamboo-reporter.git',
  documentation: 'README.md',
  debugOnly: true
});

Package.onUse(function(api) {
  api.versionsFrom('1.0.3.1');
  api.use([
    'coffeescript',
    'underscore',
    'velocity:shim@0.1.0'
  ], 'server');
  api.addFiles([
    'main.coffee'
  ], 'server');
});
