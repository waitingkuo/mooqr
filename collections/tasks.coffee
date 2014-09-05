@Tasks = new Meteor.Collection 'tasks'

Tasks.attachSchema new SimpleSchema

  taskName:
    type: String
    label: 'Task name'
    max: 200

  userId:
    type: String
    optional: true

  planId:
    type: String
    optional: true

  moduleId:
    type: String
    optional: true


Tasks.allow
  'update': -> true
  'insert': -> true
