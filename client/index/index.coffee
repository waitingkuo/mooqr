Meteor.startup ->

  #scrollHandler = ->
  #  if $(document).scrollTop() > 100
  #    $('.app-bar2').addClass 'shrink'
  #  else
  #    $('.app-bar2').removeClass 'shrink'
  #  if $(document).scrollTop() >= 192
  #    $('.app-bar2').addClass 'fixed'
  #  else
  #    $('.app-bar2').removeClass 'fixed'
  #
  #Template.index.rendered = ->
  #  $(document).on 'scroll', scrollHandler
  #
  #Template.index.destroyed = ->
  #  $(document).unbind 'scroll', scrollHandler
  #
  #
  
Template.index.events
  'click .plan2': ->
    Router.go 'plan', {_id: @_id}

Template.index.helpers
  followers: ->
    followers = 1

    if @followers? and (not isNaN(@followers)) and @followers >= 1
      followers = @followers

    followers2 = 0
    if @followers2? and (not isNaN(@followers2)) and @followers2 >= 0
      followers2 = @followers2

    return followers + followers2

    
  isContent: ->
    @planLink? or @planDescription?

    
