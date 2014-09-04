Template.plans.events
  'click .plan': (e) ->
    Router.go 'plan', _id: @_id

  'click .add-plan': (e) ->
    Blaze.render Template.planDialog, document.body

  'click .plan-more': (e) ->
    e.stopPropagation()
    #HACK #FIXME
    $(e.currentTarget).find('.menu').toggleClass('active')

#FIXME
$('*').click (e) ->
  $(e.target).find('.plan-item-more-menu').removeClass('active')

Template.plans.events
  'click .remove': (e) ->
    Meteor.call 'deletePlan', @_id

