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


    

    
