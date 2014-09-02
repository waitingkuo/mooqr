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


if Meteor.isClient
  AutoForm.hooks
    moduleDialog:
      onSubmit: (insertDoc, updateDoc, currentDoc) ->

        planId = Session.get 'currentPlanId'
        moduleName = insertDoc.moduleName

        Meteor.call 'addModule', planId, moduleName, (err, result) ->
          if not err
            UI.remove UI.moduleDialog

        @done()
        return false

Modules.allow
  'insert': -> true
  'update': -> true
