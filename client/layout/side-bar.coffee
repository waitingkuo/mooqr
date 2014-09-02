Template.sideBar.helpers
  active: ->
    isActive = Session.get 'sideBar:isActive'
    if isActive
      return 'active'
    else
      return ''



