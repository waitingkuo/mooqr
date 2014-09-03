Template.plans.events
  'click .plan': (e) ->
    Router.go 'plan', _id: @_id

  'click .add-plan': (e) ->
    
    UI.planDialog = UI.render Template.planDialog
    UI.insert UI.planDialog, $('body')[0]

Template.planDialog.helpers
  # this is strange
  planName: ->
    fieldName: 'planName'
Template.planDialog.events
  'click .cancel-button': (e) ->
    UI.remove UI.planDialog


