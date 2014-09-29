

Template.sideBar.helpers

  active: ->
    isActive = Session.get 'sideBar:isActive'
    if isActive
      return 'active'
    else
      return ''

Template.sideBar.events
  'click .item-plans': (e) ->
    # $(".followed-plans").show()
    # $(".your-plans").show()
    Session.set("searchWords",".*")

  'click .item-logout': (e) -> 
    Meteor.logout ->
      Router.go 'index'

  'click #feedback': (e) ->
    UserVoice.push ['show', '#feedback', {
      mode: 'satisfaction'
      menu_enabled: true
    }]

Template.sideBar.rendered = ->
  hammertime = new Hammer($('#side-bar')[0])
  hammertime.on 'swipeleft', ->
    isActive = Session.get 'sideBar:isActive'
    Session.set 'sideBar:isActive', (not isActive)

  Tracker.autorun ->
    if Session.get('sideBar:isActive')
      $('body').css('overflow', 'hidden')
    else
      $('body').css('overflow', 'auto')

