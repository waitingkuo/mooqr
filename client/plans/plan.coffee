Template.plan.events

  'click .add-module': (e) ->

    planId = @_id
    Session.set 'currentPlanId', planId
  
    UI.moduleDialog = UI.render Template.moduleDialog
    UI.insert UI.moduleDialog, $('body')[0]

  
Template.module.events

  'click .add-task': (e) ->

    moduleId = @_id
    Session.set 'currentModuleId', moduleId

    UI.taskDialog = UI.render Template.taskDialog
    UI.insert UI.taskDialog, $('body')[0]

    
   
  
Template.moduleDialog.helpers
  moduleName: ->
    fieldName: 'moduleName'
Template.moduleDialog.events
  'click .cancel-button': (e) ->
    UI.remove UI.moduleDialog

Template.taskDialog.helpers
  taskName: ->
    fieldName: 'taskName'
Template.taskDialog.events
  'click .cancel-button': (e) ->
    UI.remove UI.taskDialog


Template.inputTextarea.events

  'keyup': (e) ->
    $area = $(e.target)
    $area.css 'height', '0'
    scrollHeight = $area.prop('scrollHeight') - 20
    console.log scrollHeight
    $area.css 'height', scrollHeight

    
