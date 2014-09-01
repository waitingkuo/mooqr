Template.plan.events

  'click .add-module': (e) ->

    planId = @_id

    Meteor.call 'addModule', planId, 'New Module'

  
Template.module.events

  'click .add-task': (e) ->

    planId = Router.current().data()._id
    moduleId = @_id

    #Meteor.call 'addTask', planId, moduleId, 'New Task'
    #
    #
    
Template.taskDialog.helpers

  taskName: ->
    label: 'Task Name'
  #content: ->
  #  label: 'Content' 
  #
Template.taskDialog.events

  'click .save-button': (e) ->
    planId = undefined
    moduleId = undefined
    taskName = $(e.currentTarget).closest('.task-dialog').find('.task-name input').val()
    console.log taskName
  
Template.inputTextarea.events

  'keyup': (e) ->
    $area = $(e.target)
    $area.css 'height', '0'
    scrollHeight = $area.prop('scrollHeight') - 20
    console.log scrollHeight
    $area.css 'height', scrollHeight

    
