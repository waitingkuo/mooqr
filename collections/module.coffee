@Modules = new Meteor.Collection 'modules'

Modules.attachSchema new SimpleSchema

  moduleName:
    type: String
    label: 'Module name'
    max: 200

  planId:
    type: String
    optional: true

  taskIds:
    type: [String]
    optional: true


Modules.allow
  'insert': -> true
  'update': -> true
