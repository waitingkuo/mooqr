Template.appBar.events
  'click .nav-icon': (e) ->
    e.stopPropagation()
    isActive = Session.get 'sideBar:isActive'
    if isActive
      Session.set 'sideBar:isActive', false
    else
      Session.set 'sideBar:isActive', true

# FIXME should refactor
Template.appBar2.events
  'click .nav-icon': (e) ->
    e.stopPropagation()
    isActive = Session.get 'sideBar:isActive'
    if isActive
      Session.set 'sideBar:isActive', false
    else
      Session.set 'sideBar:isActive', true


Meteor.startup ->
  $(':not(.navi-icon)').click (e) ->
    Session.set 'sideBar:isActive', false
    
