Template.appBar.helpers
  isArrowBack: ->
    routeName = Router.current().route.name
    console.log routeName
    if routeName is 'plan' 
      return true
    else
      return false
    
Template.appBar.events
  'click .nav-icon .menu': (e) ->
    e.stopPropagation()
    isActive = Session.get 'sideBar:isActive'
    if isActive
      Session.set 'sideBar:isActive', false
    else
      Session.set 'sideBar:isActive', true

  'click .nav-icon .arrow-back': (e) ->
    Router.go 'plans'

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
    
