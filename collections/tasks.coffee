@Tasks = new Meteor.Collection 'tasks'

Tasks.allow
  'update': -> true
