@Tasks = new Meteor.Collection 'tasks'

Tasks.attachSchema new SimpleSchema

  taskName:
    type: String
    label: 'Task name'
    max: 200

  planId:
    type: String
    optional: true

  moduleId:
    type: String
    optional: true

if Meteor.isClient
  AutoForm.hooks
    taskDialog:
      onSubmit: (insertDoc, updateDoc, currentDoc) ->

        planId = Session.get 'currentPlanId'
        moduleId = Session.get 'currentModuleId'
        taskName = insertDoc.taskName

        Meteor.call 'addTask', planId, moduleId, taskName, (err, result) ->
          if not err
            UI.remove UI.taskDialog

        @done()
        return false


Tasks.allow
  'update': -> true
  'insert': -> true
