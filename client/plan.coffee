Template.plan.events

  'click .add-module': (e) ->

    planId = @_id

    Meteor.call 'addModule', planId, 'New Module'

  
Template.module.events

  'click .add-task': (e) ->

    planId = Router.current().data()._id
    moduleId = @_id

    Meteor.call 'addTask', planId, moduleId, 'New Task'
    

  
