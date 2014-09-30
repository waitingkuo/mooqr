#
# Plan
#
Template.planDialog.rendered = ->
  $('body').css 'overflow', 'hidden'
Template.planDialog.destroyed = ->
  $('body').css 'overflow', 'auto'
Template.planDialog.helpers
  planName: ->
    fieldName: 'planName'
  planLink: ->
    fieldName: 'planLink'
  planDescription: ->
    fieldName: 'planDescription'
Template.planDialog.events
  'click .cancel-button': (e) ->
    Blaze.remove Blaze.currentView
AutoForm.hooks
  planDialog:
    onSubmit: (insertDoc, updateDoc, currentDoc) ->

      #planName = insertDoc.planName
      #FIXME need to valid insertDoc

      Meteor.call 'createPlan', insertDoc, (err, result) ->
        if not err
          # console.log result
          mixpanel.track "[UserCreatePlan] planId:"+result
          Blaze.remove Blaze.getView($('.material-dialog')[0])
          
        else
          if err.error is 401
            Snackbars.popup "Cannot create plans. Please ... ", "LOGIN"
            mixpanel.track "[AnonymousUserError] create plans without login"
          else
            console.log err
            Snackbars.popup "Cannot create plans."
            mixpanel.track "[AnonymousUserError] create plans ERROR"

      @done()
      return false


#
# Edit Plan
#
Template.editPlanDialog.rendered = ->
  $('body').css 'overflow', 'hidden'
Template.editPlanDialog.destroyed = ->
  $('body').css 'overflow', 'auto'
Template.editPlanDialog.helpers
  planName: ->
    fieldName: 'planName'
  planLink: ->
    fieldName: 'planLink'
  planDescription: ->
    fieldName: 'planDescription'
  editingDoc: ->
    Plans.findOne Session.get('currentPlanId')
Template.editPlanDialog.events
  'click .cancel-button': (e) ->
    Blaze.remove Blaze.currentView
AutoForm.hooks
  editPlanDialog:
    onSubmit: (insertDoc, updateDoc, currentDoc) ->

      planId = currentDoc._id
      #FIXME need to valid updateDoc
      #planName = updateDoc.$set.planName

      Meteor.call 'updatePlan', planId, updateDoc, (err, result) ->
        if not err
          mixpanel.track "[UserUpdatePlan] planId:"+result
          Blaze.remove Blaze.getView($('.material-dialog')[0])
        else
          if err.error is 401
            Snackbars.popup "Cannot update plans. Please ... ", "LOGIN"
            mixpanel.track "[AnonymousUserError] update plans without login"
          else
            Snackbars.popup "Cannot update plans."
            mixpanel.track "[AnonymousUserError] update plans ERROR"

      @done()
      return false


#
# Module
#
Template.moduleDialog.rendered = ->
  $('body').css 'overflow', 'hidden'
Template.moduleDialog.destroyed = ->
  $('body').css 'overflow', 'auto'
Template.moduleDialog.helpers
  moduleName: ->
    fieldName: 'moduleName'
  moduleLink: ->
    fieldName: 'moduleLink'
  moduleDescription: ->
    fieldName: 'moduleDescription'
Template.moduleDialog.events
  'click .cancel-button': (e) ->
    Blaze.remove Blaze.currentView
AutoForm.hooks
  moduleDialog:
    onSubmit: (insertDoc, updateDoc, currentDoc) ->

      planId = Session.get 'currentPlanId'
      #moduleName = insertDoc.moduleName

      Meteor.call 'createModule', planId, insertDoc, (err, result) ->
        if not err
          Blaze.remove Blaze.getView($('.material-dialog')[0])

      @done()
      return false

#
# Edit Module
#
Template.editModuleDialog.rendered = ->
  $('body').css 'overflow', 'hidden'
Template.editModuleDialog.destroyed = ->
  $('body').css 'overflow', 'auto'
Template.editModuleDialog.helpers
  moduleName: ->
    fieldName: 'moduleName'
  moduleLink: ->
    fieldName: 'moduleLink'
  moduleDescription: ->
    fieldName: 'moduleDescription'
  editingDoc: ->
    Modules.findOne 
      _id: Session.get 'currentModuleId'
      planId: Session.get 'currentPlanId'
Template.editModuleDialog.events
  'click .cancel-button': (e) ->
    Blaze.remove Blaze.currentView
AutoForm.hooks
  editModuleDialog:
    onSubmit: (insertDoc, updateDoc, currentDoc) ->

      planId = currentDoc.planId
      moduleId = currentDoc._id
      #moduleName = updateDoc.$set.moduleName

      Meteor.call 'updateModule', planId, moduleId, updateDoc, (err, result) ->
        if not err
          Blaze.remove Blaze.getView($('.material-dialog')[0])
        else 
          console.log insertDoc, updateDoc, currentDoc
          console.log err

      @done()
      return false
      

#
# Task
#
Template.taskDialog.rendered = ->
  $('body').css 'overflow', 'hidden'
Template.taskDialog.destroyed = ->
  $('body').css 'overflow', 'auto'
Template.taskDialog.helpers
  taskName: ->
    fieldName: 'taskName'
  taskLink: ->
    fieldName: 'taskLink'
  taskDescription: ->
    fieldName: 'taskDescription'
Template.taskDialog.events
  'click .cancel-button': (e) ->
    Blaze.remove Blaze.currentView
AutoForm.hooks
  taskDialog:
    onSubmit: (insertDoc, updateDoc, currentDoc) ->

      planId = Session.get 'currentPlanId'
      moduleId = Session.get 'currentModuleId'
      #taskName = insertDoc.taskName

      Meteor.call 'createTask', planId, moduleId, insertDoc, (err, result) ->
        if not err
          Blaze.remove Blaze.getView($('.material-dialog')[0])

      @done()
      return false
