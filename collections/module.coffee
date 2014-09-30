@Modules = new Meteor.Collection 'modules'

Modules.attachSchema new SimpleSchema

  moduleName:
    type: String
    label: 'Module Name *'
    max: 200

  moduleLink:
    type: String
    label: 'Module Link'
    regEx: SimpleSchema.RegEx.Url
    optional: true

  moduleDescription:
    type: String
    label: 'Module Description'
    optional: true
    
  userId:
    type: String
    optional: true

  planId:
    type: String
    optional: true

  taskIds:
    type: [String]
    #optional: true
    autoValue: ()->
      if @isInsert
        new Array()


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



Modules.allow
  'insert': -> true
  'update': -> true



