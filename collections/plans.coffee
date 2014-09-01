@Plans = new Meteor.Collection 'plans'

Meteor.methods

  'createPlan': (planName) ->

    plan =
      planName: planName
      moduleIds: []

    Plans.insert plan


  'updatePlan': (planId, planName) ->

    Plans.update planId,
      planName: planName


  'deletePlan': (planId) ->
    # FIXME 
    'consider whether we make it public or not'


  'addModule': (planId, moduleName) ->

    module =
      moduleName: moduleName
      planId: planId
      taskIds: []

    moduleId = Modules.insert module
    
    Plans.update planId,
      $push:
        moduleIds: moduleId
      
    moduleId


  'updateModule': (moduleId, moduleName) ->
    console.log 'woo'

  'moveModule': (planId, moduleId, fromModulePos, toModulePos) ->
    console.log 'woo'

  'deleteModule': (planId, moduleId) ->
    console.log 'woo'


  'addTask': (planId, moduleId, taskName) ->

    task =
      taskName: taskName
      planId: planId
      moduleId: moduleId

    taskId = Tasks.insert task
    
    Modules.update moduleId,
      $push:
        taskIds: taskId

    taskId


  'updateTask': (taskId, taskName) ->
    console.log 'woo'

  'moveTask': (taskId, fromModuleId, fromTaskPos, toModuleId, toTaskPos) ->
    console.log 'woo'

  'deleteTask': (moduleId, taskId) ->
    console.log 'woo'
  




#@CoursePlans = new Meteor.Collection 'coursePlans'

#CoursePlans.allow
  # FIXME
#  'update': -> true

#if Meteor.isServer

#  Meteor.methods
#    'updateCoursePlanTask': (coursePlanId, taskId, done) ->

#      selector =
#        _id: coursePlanId
#        'modules.tasks.taskId': taskId

#      modifier =
#        $set:
#          'modules.$.done': done

#      console.log selector, modifier

#      CoursePlans.update selector, modifier


