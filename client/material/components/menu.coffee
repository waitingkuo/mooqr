Template.menuButton.events
  'click .material-menu-icon': (e) ->
    e.stopPropagation()
    window.v= Blaze.currentView
    view = Blaze.renderWithData Template.menu, @, Blaze.currentView

    $(document).click (e) ->
      Blaze.remove view
      $(e.currentTarget).unbind e.type, arguments.callee


Template.menuItem.events
  'click': (e) ->
    @clickEvent?(e)

