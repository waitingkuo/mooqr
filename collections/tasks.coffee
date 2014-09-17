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

  createAt:
    type: Date
    autoValue: ()->
      if @isInsert
        newDate = new Date
        newDate

      else if @isUpsert
        newDate = new Date
        upsertOption = 
          $setOnInsert: newDate
        upsertOption
      else
        @unset()

    #FIXME: modify data and remove this option
    optional: true

  updateAt:
    type: Date
    autoValue: ()->
      if @isUpate
        newDate = new Date
        newDate
    denyInsert: true
    optional: true



Tasks.allow
  'update': -> true
  'insert': -> true
