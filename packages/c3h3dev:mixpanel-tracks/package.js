Package.describe("mixpanelTracks");

Package.onUse(function(api) {
  api.add_files(['mixpanel.js'],"client");
});

// Package.onTest(function(api) {
//   api.use('tinytest');
//   api.use('c3h3dev:mixpanel-tracks');
//   api.addFiles('c3h3dev:mixpanel-tracks-tests.js');
// });
