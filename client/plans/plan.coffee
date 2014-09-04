Template.plan.events

  'click .add-module': (e) ->

    planId = @_id
    Session.set 'currentPlanId', planId
  
    Blaze.render Template.moduleDialog, document.body

  
Template.module.events

  'click .add-task': (e) ->

    moduleId = @_id
    Session.set 'currentModuleId', moduleId

    Blaze.render Template.taskDialog, document.body

    
