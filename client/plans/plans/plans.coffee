Template.plans.events
  #'click .plan': (e) ->
  #  Router.go 'plan', _id: @_id
  'click .plan2': (e) ->
    Router.go 'plan', _id: @_id

  'click .add-plan': (e) ->
    Blaze.render Template.planDialog, document.body

  #'click .plan-more': (e) ->
  #  e.stopPropagation()
  #  #HACK #FIXME
  #  $(e.currentTarget).find('.menu').toggleClass('active')

  'click .follow': (e) ->
    e.stopPropagation()

    planId = @_id

    Meteor.call 'followPlan', planId, (err, result) ->
      console.log "user follow plan: "
      console.log result
      if result.status is "success"
        mixpanel.track result.mixpanel


  'click .unfollow': (e) ->
    e.stopPropagation()

    planId = @_id

    Meteor.call 'unfollowPlan', planId, (err, result) ->
      console.log "user unfollow plan: "
      console.log result
      if result.status is "success"
        mixpanel.track result.mixpanel

  'change input.search-keyword': (e) ->
    
    e.stopPropagation()

    $(".followed-plans").hide()
    $(".your-plans").hide()
    _searchWords = $(e.target).val()
    searchWords = ( xx for xx in _searchWords.split(" ") when xx isnt "").join "|"
    Session.set "searchWords", searchWords

    user = Meteor.user()
    if user
      mixpanel.track "[test][UserSearch] searchWords:" + searchWords
    else
      mixpanel.track "[test][AnonymousUserSearch] searchWords:" + searchWords



    





    # userId = Meteor.userId()
    # planId = @_id

    # userPlan =
    #   userId: userId
    #   planId: planId
    #   isOwner: false

    # if not UserPlans.findOne {userId: userId, planId: planId}
    #   UserPlans.insert userPlan

   

#FIXME
$('*').click (e) ->
  $(e.target).find('.plan-item-more-menu').removeClass('active')

Template.plans.events
  'click .rename': (e) ->
    Session.set 'currentPlanId', @_id
    Blaze.render Template.editPlanDialog, document.body 

  'click .remove': (e) ->
    Meteor.call 'deletePlan', @_id

