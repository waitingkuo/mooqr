disableScrolling = ->
  #$('body').css 'overflow', 'hidden'

enableScrolling = ->
  #$('body').css 'overflow', 'auto'

#
# Plan
#
Template.planDialog.rendered = disableScrolling
Template.planDialog.destroyed = enableScrolling
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

          planId = result
          GAnalytics.event 'plan', 'create', planId
          Router.go 'plan', {_id: planId}

          
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
Template.editPlanDialog.rendered = disableScrolling
Template.editPlanDialog.destroyed = enableScrolling
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
Template.moduleDialog.rendered = disableScrolling
Template.moduleDialog.destroyed = enableScrolling
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
Template.editModuleDialog.rendered = disableScrolling
Template.editModuleDialog.destroyed = enableScrolling
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
Template.taskDialog.rendered = disableScrolling
Template.taskDialog.destroyed = enableScrolling
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


#
# Edit Task 
#
Template.editTaskDialog.rendered = disableScrolling
Template.editTaskDialog.destroyed = enableScrolling
Template.editTaskDialog.helpers
  taskName: ->
    fieldName: 'taskName'
  taskLink: ->
    fieldName: 'taskLink'
  taskDescription: ->
    fieldName: 'taskDescription'
  editingDoc: ->
    Tasks.findOne 
      _id: Session.get 'currentTaskId'
      planId: Session.get 'currentPlanId'
Template.editTaskDialog.events
  'click .cancel-button': (e) ->
    Blaze.remove Blaze.currentView
AutoForm.hooks
  editTaskDialog:
    onSubmit: (insertDoc, updateDoc, currentDoc) ->

      planId = currentDoc.planId
      moduleId = currentDoc.moduleId
      taskId = currentDoc._id
      #taskName = updateDoc.$set.taskName

      Meteor.call 'updateTask', planId, moduleId, taskId, updateDoc, (err, result) ->
        if not err
          Blaze.remove Blaze.getView($('.material-dialog')[0])
        else 
          console.log insertDoc, updateDoc, currentDoc
          console.log err

      @done()
      return false
