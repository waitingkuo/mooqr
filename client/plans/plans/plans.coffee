Template.plans.helpers

  isOwnedPlans: -> @ownedPlans().count() > 0
  isFollowedPlans: -> @followedPlans().count() > 0
  isSearching: ->
    not Session.equals 'searchWords', '.*'

  planMenuData: ->
    items: [
      {
        label: 'Edit'
        clickEvent: (e) ->
          e.stopPropagation()
          Blaze.render Template.editPlanDialog, document.body
      }
      {
        label: 'Delete'
        clickEvent: (e) =>
          e.stopPropagation()
          Meteor.call 'deletePlan', @_id
      }
    ]
  
Template.plans.events
  'click .plan2': (e) ->
    Router.go 'plan', _id: @_id

  'click .add-plan': (e) ->
    Blaze.render Template.planDialog, document.body

  'click .follow': (e) ->
    e.stopPropagation()

    planId = @_id

    Meteor.call 'followPlan', planId, (err, result) ->
      if not err
        # console.log "user follow plan: "
        # console.log result
        if result.status is "success"
          Snackbars.popup "Follow plan successfully!"
          mixpanel.track result.mixpanel

      else
        if err.error is 401
          Snackbars.popup "Cannot follow plans. Please ... ", "LOGIN"
          mixpanel.track "[AnonymousUserError] follow plans without login"
        else
          Snackbars.popup "Cannot follow plans."
          mixpanel.track "[AnonymousUserError] follow plans ERROR"



  'click .unfollow': (e) ->
    e.stopPropagation()

    planId = @_id

    Meteor.call 'unfollowPlan', planId, (err, result) ->
      if not err
        # console.log "user unfollow plan: "
        # console.log result
        if result.status is "success"
          Snackbars.popup "Unfollow plan successfully!"
          mixpanel.track result.mixpanel

      else
        if err.error is 401
          Snackbars.popup "Cannot unfollow plans. Please ... ", "LOGIN"
          mixpanel.track "[AnonymousUserError] unfollow plans without login"
        else
          Snackbars.popup "Cannot unfollow plans."
          mixpanel.track "[AnonymousUserError] unfollow plans ERROR"





delay = ( ->
  timer = 0
  return (callback, ms) ->
    clearTimeout timer
    timer = setTimeout(callback, ms)
)()

Template.searchPlans.helpers
  isSearching: ->
    not Session.equals 'searchWords', '.*'
  searchWords: -> 
    Session.get 'searchWords'


Template.searchPlans.events

  'click .search-clear': (e) ->
    #$(".followed-plans").show()
    #$(".your-plans").show()
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
        # $(".followed-plans").hide()
        # $(".your-plans").hide()
        Session.set "searchWords", searchWords.join("|")
      else
        # $(".followed-plans").show()
        # $(".your-plans").show()
        Session.set "searchWords", ".*"
     
      user = Meteor.user()
      if user
        mixpanel.track "[UserSearch] searchWords:" + _searchWords
      else
        mixpanel.track "[AnonymousUserSearch] searchWords:" + _searchWords
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

