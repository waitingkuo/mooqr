Template.plan.events

  'click .add-module': (e) ->

    planId = @_id
    Session.set 'currentPlanId', planId
  
    Blaze.render Template.moduleDialog, document.body

  'click .plan-more-button': (e) ->

    e.stopPropagation()

    $menu = $(e.currentTarget).next()
    $menu.addClass 'active'
    $('html').one 'click', ->
      $menu.removeClass 'active'
    
  'click .rename': (e) ->
    Blaze.render Template.editPlanDialog, document.body



  
Template.module.events

  'click .module-more-button': (e) ->

    e.stopPropagation()

    $menu = $(e.currentTarget).next()
    $menu.addClass 'active'
    $('html').one 'click', ->
      $menu.removeClass 'active'

  'click .add-task': (e) ->

    moduleId = @_id
    Session.set 'currentModuleId', moduleId

    Blaze.render Template.taskDialog, document.body

  'click .remove-module': (e) ->

    planId = Session.get 'currentPlanId'
    moduleId = @_id

    Meteor.call 'deleteModule', planId, moduleId
    
  'click .edit-module': (e) ->

    moduleId = @_id
    Session.set 'currentModuleId', moduleId
  
    Blaze.render Template.editModuleDialog, document.body
