

Template.sideBar.helpers

  active: ->
    isActive = Session.get 'sideBar:isActive'
    if isActive
      return 'active'
    else
      return ''

Template.sideBar.events

  'click .item-logout': (e) -> Meteor.logout()

  'click #feedback': (e) ->
    UserVoice.push ['show', '#feedback', {
      mode: 'satisfaction'
      menu_enabled: true
    }]
