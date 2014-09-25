SnackbarMessages = new Meteor.Collection null

@Snackbars =
  popup: (message, button, callback) ->
    #FIXME should find a way to pass the callback
    SnackbarMessages.insert
      message: message
      button: button
  # FIXME it's better to reset automatically
  reset: ->
    SnackbarMessages.find().forEach (doc) -> 
      SnackbarMessages.remove(doc)


Template.snackbars.messages = -> SnackbarMessages.find()
Template.snackbar.events
  #FIXME should find a way to pass the callback
  'click .button': -> Meteor.loginWithGoogle()
