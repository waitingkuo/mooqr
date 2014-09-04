Template.plans.events
  'click .plan': (e) ->
    Router.go 'plan', _id: @_id

  'click .add-plan': (e) ->
    Blaze.render Template.planDialog, document.body


