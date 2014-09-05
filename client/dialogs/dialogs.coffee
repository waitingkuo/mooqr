Template.inputTextarea.events

  'keyup': (e) ->
    $area = $(e.target)
    $area.css 'height', '0'
    scrollHeight = $area.prop('scrollHeight') - 20
    console.log scrollHeight
    $area.css 'height', scrollHeight


# Plan Dialog
Template.planDialog.helpers
  # this is strange
  planName: ->
    fieldName: 'planName'
Template.planDialog.events
  'click .cancel-button': (e) ->
    Blaze.remove Blaze.currentView
Template.editPlanDialog.helpers
  # this is strange
  planName: ->
    fieldName: 'planName'
  editingDoc: ->
    Plans.findOne Session.get('currentPlanId')

Template.editPlanDialog.events
  'click .cancel-button': (e) ->
    Blaze.remove Blaze.currentView


# Module Dialog
Template.moduleDialog.helpers
  moduleName: ->
    fieldName: 'moduleName'
Template.moduleDialog.events
  'click .cancel-button': (e) ->
    Blaze.remove Blaze.currentView
Template.editModuleDialog.helpers
  # this is strange
  moduleName: ->
    fieldName: 'moduleName'
  editingDoc: ->
    Modules.findOne 
      _id: Session.get 'currentModuleId'
      planId: Session.get 'currentPlanId'
Template.editModuleDialog.events
  'click .cancel-button': (e) ->
    Blaze.remove Blaze.currentView
      


#Task Dialog
Template.taskDialog.helpers
  taskName: ->
    fieldName: 'taskName'
Template.taskDialog.events
  'click .cancel-button': (e) ->
    Blaze.remove Blaze.currentView


AutoForm.hooks

  planDialog:
    onSubmit: (insertDoc, updateDoc, currentDoc) ->

      planName = insertDoc.planName

      Meteor.call 'createPlan', planName, (err, result) ->
        if not err
          Blaze.remove Blaze.getView($('.plan-dialog')[0])

      @done()
      return false

  editPlanDialog:
    onSubmit: (insertDoc, updateDoc, currentDoc) ->

      planId = currentDoc._id
      planName = updateDoc.$set.planName

      Meteor.call 'updatePlan', planId, planName, (err, result) ->
        if not err
          Blaze.remove Blaze.getView($('.plan-dialog')[0])

      @done()
      return false


  moduleDialog:
    onSubmit: (insertDoc, updateDoc, currentDoc) ->

      planId = Session.get 'currentPlanId'
      moduleName = insertDoc.moduleName

      Meteor.call 'addModule', planId, moduleName, (err, result) ->
        if not err
          Blaze.remove Blaze.getView($('.module-dialog')[0])

      @done()
      return false


  editModuleDialog:
    onSubmit: (insertDoc, updateDoc, currentDoc) ->

      planId = currentDoc.planId
      moduleId = currentDoc._id
      moduleName = updateDoc.$set.moduleName

      Meteor.call 'updateModule', planId, moduleId, moduleName, (err, result) ->
        if not err
          Blaze.remove Blaze.getView($('.module-dialog')[0])
        else 
          console.log insertDoc, updateDoc, currentDoc
          console.log err

      @done()
      return false


  taskDialog:
    onSubmit: (insertDoc, updateDoc, currentDoc) ->

      planId = Session.get 'currentPlanId'
      moduleId = Session.get 'currentModuleId'
      taskName = insertDoc.taskName

      Meteor.call 'addTask', planId, moduleId, taskName, (err, result) ->
        if not err
          Blaze.remove Blaze.getView($('.task-dialog')[0])

      @done()
      return false
