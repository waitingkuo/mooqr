Meteor.startup ->

  

  # #mixpanel.track "[test] mooqr start"

  # user = Meteor.user()

  # if user and not Meteor.loggingIn()
  #   mixpanel.identify user._id
  #   mixpanel.people.set
  #     "$email": user.profile.email
  #   mixpanel.track "[test] record user first account!"

  # if user
  #   mixpanel.identify user._id
  #   mixpanel.people.set
  #     "$email": user.profile.email
  #   mixpanel.track "[test] record user already has account!"


  scrollHandler = ->
    if $(document).scrollTop() > 100
      $('.app-bar2').addClass 'shrink'
    else
      $('.app-bar2').removeClass 'shrink'
    if $(document).scrollTop() >= 192
      $('.app-bar2').addClass 'fixed'
    else
      $('.app-bar2').removeClass 'fixed'

  Template.index.rendered = ->
    $(document).on 'scroll', scrollHandler

  Template.index.destroyed = ->
    $(document).unbind 'scroll', scrollHandler


    

    
