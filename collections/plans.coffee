@Plans = new Meteor.Collection 'plans'

Plans.attachSchema new SimpleSchema

  userId:
    type: String
    optional: true

  planName:
    type: String
    label: 'Plan name'
    max: 200

  planUrl:
    type: String
    optional: true

  moduleIds:
    type: [String]
    optional: true

  createAt:
    type: Date
    autoValue: ()->
      if @isInsert
        newDate = new Date
        newDate

      else if @isUpsert
        newDate = new Date
        upsertOption = 
          $setOnInsert: newDate
        upsertOption
      else
        @unset()

    #FIXME: modify data and remove this option
    optional: true

  updateAt:
    type: Date
    autoValue: ()->
      if @isUpate
        newDate = new Date
        newDate
    denyInsert: true
    optional: true



Meteor.methods

  'createPlan': (planName, description) ->

    userId = Meteor.userId()

    # FIXME reject if not userId

    plan =
      userId: userId
      planName: planName
      moduleIds: []

    planId = Plans.insert plan

    userPlan = 
      userId: userId
      planId: planId
      isOwner: true


    UserPlans.insert userPlan

    planId


  'updatePlan': (planId, planName) ->

    userId = Meteor.userId()

    selector =
      _id: planId
      userId: userId

    modifier =
      $set:
        planName: planName

    Plans.update selector, modifier


  'deletePlan': (planId) ->
    # FIXME 
    'consider whether we make it public or not'

    userId = Meteor.userId()
    Plans.remove 
      _id: planId
      userId: userId

    #FIXME
    
    #should also delete modules and tasks


  'createModule': (planId, moduleName, description) ->

    userId = Meteor.userId()

    module =
      moduleName: moduleName
      userId: userId
      planId: planId
      taskIds: []


    if description
      module.description = description


    moduleId = Modules.insert module
    
    Plans.update planId,
      $push:
        moduleIds: moduleId
      
    moduleId


  'updateModule': (planId, moduleId, moduleName, description) ->

    userId = Meteor.userId()

    selector =
      _id: moduleId
      userId: userId
      planId: planId

    updater = {}

    if moduleName
      updater.moduleName = moduleName

    if description
      updater.description = description



    modifier =
      $set: updater

    Modules.update selector, modifier


  "moveModule": (planId, moduleId, position) ->
    #FIXME: checking planId & moduleId
    planData = Plans.findOne _id:planId

    # console.log "old planData:" 
    # console.log planData 
    
    moduleIdsArr = planData.moduleIds
    newModuleIdsArr = moduleIdsArr.filter (mid) -> mid isnt moduleId
    newModuleIdsArr.splice position,0,moduleId

    # console.log "newModuleIdsArr:"
    # console.log newModuleIdsArr
    
    planData.moduleIds = newModuleIdsArr

    Plans.update {_id:planId}, {$set:{moduleIds:newModuleIdsArr}}

    # console.log "new planData:"
    # console.log Plans.findOne _id:planId



  'deleteModule': (planId, moduleId) ->

    # FIXME 
    'consider whether we make it public or not'

    userId = Meteor.userId()

    Plans.update planId,
      $pull:
        moduleIds: moduleId

    Modules.remove
      _id: moduleId,
      planId: planId
      userId: userId

    #FIXME
    
    #should also delete tasks


  'createTask': (planId, moduleId, taskName) ->

    userId = Meteor.userId()

    task =
      taskName: taskName
      userId: userId
      planId: planId
      moduleId: moduleId

    taskId = Tasks.insert task
    
    Modules.update moduleId,
      $push:
        taskIds: taskId

    taskId


  'updateTask': (taskId, taskName) ->
    console.log 'woo'

  'moveTask': (taskId, fromModuleId, toModuleId, toTaskPos) ->
    #FIXME: checking validation of Ids
    fromModule = Modules.findOne _id:fromModuleId
    
    fromModuleTasksArr = fromModule.taskIds
    newFromModuleTasksArr = fromModuleTasksArr.filter (tid) -> tid isnt taskId
    Modules.update {_id:fromModuleId}, {$set:{taskIds:newFromModuleTasksArr}}

    toModule = Modules.findOne _id:toModuleId
    toModuleTasksArr = toModule.taskIds
    toModuleTasksArr.splice toTaskPos,0,taskId
    Modules.update {_id:toModuleId}, {$set:{taskIds:toModuleTasksArr}}
    

  'deleteTask': (moduleId, taskId) ->
    console.log 'woo'
  


