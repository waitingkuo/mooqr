#
# Plan
#
Template.planDialog.helpers
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
          Blaze.remove Blaze.getView($('.material-dialog')[0])

      @done()
      return false


#
# Edit Plan
#
Template.editPlanDialog.helpers
  planName: ->
    fieldName: 'planName'
  editingDoc: ->
    Plans.findOne Session.get('currentPlanId')
Template.editPlanDialog.events
  'click .cancel-button': (e) ->
    Blaze.remove Blaze.currentView
AutoForm.hooks
  editPlanDialog:
    onSubmit: (insertDoc, updateDoc, currentDoc) ->

      planId = currentDoc._id
      planName = updateDoc.$set.planName

      Meteor.call 'updatePlan', planId, planName, (err, result) ->
        if not err
          Blaze.remove Blaze.getView($('.material-dialog')[0])

      @done()
      return false


#
# Module
#
Template.moduleDialog.helpers
  moduleName: ->
    fieldName: 'moduleName'
Template.moduleDialog.events
  'click .cancel-button': (e) ->
    Blaze.remove Blaze.currentView
AutoForm.hooks
  moduleDialog:
    onSubmit: (insertDoc, updateDoc, currentDoc) ->

      planId = Session.get 'currentPlanId'
      moduleName = insertDoc.moduleName

      Meteor.call 'createModule', planId, moduleName, (err, result) ->
        if not err
          Blaze.remove Blaze.getView($('.material-dialog')[0])

      @done()
      return false

#
# Edit Module
#
Template.editModuleDialog.helpers
  moduleName: ->
    fieldName: 'moduleName'
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
      moduleName = updateDoc.$set.moduleName

      Meteor.call 'updateModule', planId, moduleId, moduleName, (err, result) ->
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
Template.taskDialog.helpers
  taskName: ->
    fieldName: 'taskName'
Template.taskDialog.events
  'click .cancel-button': (e) ->
    Blaze.remove Blaze.currentView
AutoForm.hooks
  taskDialog:
    onSubmit: (insertDoc, updateDoc, currentDoc) ->

      planId = Session.get 'currentPlanId'
      moduleId = Session.get 'currentModuleId'
      taskName = insertDoc.taskName

      Meteor.call 'createTask', planId, moduleId, taskName, (err, result) ->
        if not err
          Blaze.remove Blaze.getView($('.material-dialog')[0])

      @done()
      return false
