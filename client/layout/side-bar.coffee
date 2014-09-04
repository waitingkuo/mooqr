

Template.sideBar.helpers
  
  user: Meteor.user()

  active: ->
    isActive = Session.get 'sideBar:isActive'
    if isActive
      return 'active'
    else
      return ''
