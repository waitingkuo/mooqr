@Modules = new Meteor.Collection 'modules'

Modules.allow
  'update': -> true
