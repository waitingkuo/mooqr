@Plans = new Meteor.Collection 'plans'

Plans.attachSchema new SimpleSchema

  planName:
    type: String
    label: 'Plan name'
    max: 200

  moduleIds:
    type: [String]
    optional: true


Meteor.methods

  'createPlan': (planName) ->

    plan =
      planName: planName
      moduleIds: []

    Plans.insert plan


  'updatePlan': (planId, planName) ->

    Plans.update planId,
      $set:
        planName: planName


  'deletePlan': (planId) ->
    # FIXME 
    'consider whether we make it public or not'
    Plans.remove planId
    #FIXME
    #should also delete modules and tasks


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
  


