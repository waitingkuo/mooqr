Template.plans.helpers

  isOwnedPlans: -> @ownedPlans().count() > 0
  isFollowedPlans: -> @followedPlans().count() > 0

Template.plans.events
  'click .plan2': (e) ->
    Router.go 'plan', _id: @_id

  'click .add-plan': (e) ->
    Blaze.render Template.planDialog, document.body

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


delay = ( ->
  timer = 0
  return (callback, ms) ->
    clearTimeout timer
    timer = setTimeout(callback, ms)
)()
Template.searchPlans.events

  'click .search-clear': (e) ->
    $(".followed-plans").show()
    $(".your-plans").show()
    $('.search-input input').val('')
    Session.set "searchWords", ".*"

  'keyup input.search-keyword': (e) ->
    
    e.stopPropagation()

    _searchWords = $(e.target).val()

    delay (->
      searchWords = _searchWords
      console.log searchWords
      searchWords = ( xx for xx in _searchWords.split(" ") when xx isnt "")
      if searchWords.length > 0
        $(".followed-plans").hide()
        $(".your-plans").hide()
        Session.set "searchWords", searchWords.join("|")
      else
        $(".followed-plans").show()
        $(".your-plans").show()
        Session.set "searchWords", ".*"
     
      user = Meteor.user()
      if user
        mixpanel.track "[test][UserSearch] searchWords:" + _searchWords
      else
        mixpanel.track "[test][AnonymousUserSearch] searchWords:" + _searchWords
    ), 1000


#FIXME
$('*').click (e) ->
  $(e.target).find('.plan-item-more-menu').removeClass('active')

Template.plans.events
  'click .rename': (e) ->
    Session.set 'currentPlanId', @_id
    Blaze.render Template.editPlanDialog, document.body 

  'click .remove': (e) ->
    Meteor.call 'deletePlan', @_id

