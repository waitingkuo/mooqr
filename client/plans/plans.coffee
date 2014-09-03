Template.plans.events
  'click .plan': (e) ->
    Router.go 'plan', _id: @_id

  'click .add-plan': (e) ->
    Blaze.render Template.planDialog, document.body

Template.planDialog.helpers
  # this is strange
  planName: ->
    fieldName: 'planName'
Template.planDialog.events
  'click .cancel-button': (e) ->
    Blaze.remove Blaze.currentView

AutoForm.hooks
  planDialog:
    onSubmit: (insertDoc, updateDoc, currentDoc) ->

      planName = insertDoc.planName

      Meteor.call 'createPlan', planName, (err, result) ->
        if not err
          Blaze.remove Blaze.getView($('.plan-dialog')[0])

      @done()
      return false

