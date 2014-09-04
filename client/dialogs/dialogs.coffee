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


# Module Dialog
Template.moduleDialog.helpers
  moduleName: ->
    fieldName: 'moduleName'
Template.moduleDialog.events
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


  moduleDialog:
    onSubmit: (insertDoc, updateDoc, currentDoc) ->

      planId = Session.get 'currentPlanId'
      moduleName = insertDoc.moduleName

      Meteor.call 'addModule', planId, moduleName, (err, result) ->
        if not err
          UI.remove UI.moduleDialog

      @done()
      return false


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
