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


Template.plan.helpers

  isOwner: () ->
    Meteor.userId() is @userId

Template.module.helpers

  isOwner: () ->
    Meteor.userId() is @userId
  
