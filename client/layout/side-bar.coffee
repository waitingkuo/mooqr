

Template.sideBar.helpers

  active: ->
    isActive = Session.get 'sideBar:isActive'
    if isActive
      return 'active'
    else
      return ''

Template.sideBar.events
  'click .item-plans': (e) ->
    $(".followed-plans").show()
    $(".your-plans").show()
    Session.set("searchWords",".*")

  'click .item-logout': (e) -> 
    Meteor.logout ->
      Router.go 'index'

  'click #feedback': (e) ->
    UserVoice.push ['show', '#feedback', {
      mode: 'satisfaction'
      menu_enabled: true
    }]
