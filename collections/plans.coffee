@Plans = new Meteor.Collection 'plans'

Plans.attachSchema new SimpleSchema

  userId:
    type: String
    optional: true

  planName:
    type: String
    label: 'Plan Name *'
    max: 200

  planLink:
    type: String
    label: 'Plan Link'
    regEx: SimpleSchema.RegEx.Url
    optional: true

  planDescription:
    type: String
    label: 'Plan Description'
    optional: true

  moduleIds:
    type: [String]
    #optional: true
    autoValue: ()->
      if @isInsert
        new Array()

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

  deleted:
    type: Boolean
    optional: true
    defaultValue: false

  followers:
    type: Number
    optional: true
    defaultValue: 1

  followers2:
    type: Number
    optional: true
    defaultValue: 0

  featured:
    type: Number
    optional: true
    defaultValue: 0

Meteor.methods

  'createPlan': (insertPlan) ->

    user = Meteor.user()

    if !user
      throw new Meteor.Error(401, "You need to login to post new stories")
      

    userId = user._id

    plan = _.extend insertPlan,
      userId: userId
      moduleIds: []

    planId = Plans.insert plan

    userPlan =
      userId: userId
      planId: planId
      isOwner: true

    UserPlans.insert userPlan

    planId


  'updatePlan': (planId, updatePlan) ->

    user = Meteor.user()

    if !user
      throw new Meteor.Error(401, "You need to login to post new stories")

    userId = user._id

    selector =
      _id: planId
      userId: userId

    #modifier =
    #  $set:
    #    planName: plan.planName
    #    planName: plan.planName
    modifier = updatePlan

    Plans.update selector, modifier

    planId


  'deletePlan': (planId) ->
    # FIXME 
    'consider whether we make it public or not'

    user = Meteor.user()

    if !user
      throw new Meteor.Error(401, "You need to login to post new stories")

    userId = user._id
     
    Plans.update {
      _id: planId
      userId: userId
    }, {
      $set:
        deleted: true
    }

    #FIXME
    
    #should also delete modules and tasks

  'followPlan': (planId) ->
    # console.log "TODO: Meteor.methods.followPlan"

    user = Meteor.user()

    if !user
      throw new Meteor.Error(401, "You need to login to post new stories")

    userId = user._id

    userPlan =
      userId: userId
      planId: planId
      isOwner: false

    if not UserPlans.findOne {userId: userId, planId: planId}
      UserPlans.insert userPlan, ->
        Plans.update planId,
          $inc:
            followers: 1
      returnObj = 
        status: "success"
        mixpanel: "[test][UserFollowPlan] planId:" + planId


    


  'unfollowPlan': (planId) ->
    # console.log "TODO: Meteor.methods.followPlan"

    user = Meteor.user()

    if !user
      throw new Meteor.Error(401, "You need to login to post new stories")

    userId = user._id
    
    UserPlans.remove {userId: userId, planId: planId}, ->
      Plans.update planId,
        $inc:
          followers: -1
    returnObj = 
        status: "success"
        mixpanel: "[test][UserUnfollowPlan] planId:" + planId




  'createModule': (planId, insertModule, description) ->

    user = Meteor.user()

    if !user
      throw new Meteor.Error(401, "You need to login to post new stories")

    userId = user._id

    #module =
    #  moduleName: moduleName
    #  userId: userId
    #  planId: planId
    #  taskIds: []
    module = _.extend insertModule,
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


  'updateModule': (planId, moduleId, updateModule) ->

    user = Meteor.user()

    if !user
      throw new Meteor.Error(401, "You need to login to post new stories")

    userId = user._id

    selector =
      _id: moduleId
      userId: userId
      planId: planId

    #modifier =
    #  $set: updater

    Modules.update selector, updateModule


  "moveModule": (planId, moduleId, position) ->

    user = Meteor.user()

    if !user
      throw new Meteor.Error(401, "You need to login to post new stories")

    userId = user._id

    # console.log "planId:"
    # console.log planId

    #FIXME: checking planId & moduleId
    planData = Plans.findOne _id:planId

    if planData.userId isnt userId
      throw new Meteor.Error(402, "You need to be the owner of plan to move the module")

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

    user = Meteor.user()

    if !user
      throw new Meteor.Error(401, "You need to login to post new stories")

    userId = user._id

    Plans.update {
      _id: planId
      userId: userId
    }, {
      $pull:
        moduleIds: moduleId
    }, ->
      Modules.remove
        _id: moduleId,
        planId: planId
        userId: userId


  'createTask': (planId, moduleId, insertTask) ->

    user = Meteor.user()

    if !user
      throw new Meteor.Error(401, "You need to login to post new stories")

    userId = user._id

    #task =
    #  taskName: taskName
    #  userId: userId
    #  planId: planId
    #  moduleId: moduleId
    task = _.extend insertTask,
      userId: userId
      planId: planId
      moduleId: moduleId


    taskId = Tasks.insert task
    
    Modules.update moduleId,
      $push:
        taskIds: taskId

    taskId


  'updateTask': (planId, moduleId, taskId, updateTask) ->

    user = Meteor.user()

    if !user
      throw new Meteor.Error(401, "You need to login first")

    userId = user._id

    selector =
      _id: taskId
      userId: userId
      planId: planId

    Tasks.update selector, updateTask


  'moveTask': (taskId, fromModuleId, toModuleId, toTaskPos) ->

    user = Meteor.user()

    if !user
      throw new Meteor.Error(401, "You need to login to post new stories")

    userId = user._id

    planId = Tasks.findOne(_id:taskId).planId
    planData = Plans.findOne _id:planId

    if planData.userId isnt userId
      throw new Meteor.Error(402, "You need to be the owner of plan to move the task")

    # console.log "~~~~~~~~~~~~~~~~"
    # console.log "fromModuleId"
    # console.log fromModuleId
    # console.log "toModOneuleId"
    # console.log toModuleId
    

    if fromModuleId is toModuleId
      # console.log "fromModuleId is toModuleId"
      
      module = Modules.findOne _id: toModuleId
      
      # console.log "module"
      # console.log module.taskIds
      # console.log "toTaskPos"
      # console.log toTaskPos
      
      newTaskIds = module.taskIds.filter (tid) -> tid isnt taskId
      newTaskIds.splice toTaskPos,0,taskId
      
      _newTaskIds = []
      _newTaskIds.push xx for xx in newTaskIds when xx not in _newTaskIds


      # console.log "newTaskIds"
      # console.log  newTaskIds
      
      Modules.update {_id: toModuleId},{"$set":{"taskIds":_newTaskIds}}
      # Modules.update {_id: toModuleId},{"$pullAll":{"taskIds":[taskId]}} 

    else

      # console.log "fromModuleId isnt toModuleId"
      # console.log Modules.findOne _id:fromModuleId

      Modules.update {_id: fromModuleId},{"$pullAll":{"taskIds":[taskId]}} 

      toModule = Modules.findOne _id: toModuleId
      newTaskIds = toModule.taskIds.filter (tid) -> tid isnt taskId
      newTaskIds.splice toTaskPos,0,taskId

      _newTaskIds = []
      _newTaskIds.push xx for xx in newTaskIds when xx not in _newTaskIds

      Modules.update {_id: toModuleId},{"$set":{"taskIds":_newTaskIds}}

      Tasks.update _id:taskId, {"$set":{"moduleId":toModuleId}}








    # #FIXME: checking validation of Ids
    # fromModule = Modules.findOne _id:fromModuleId
    
    # fromModuleTasksArr = fromModule.taskIds
    # newFromModuleTasksArr = fromModuleTasksArr.filter (tid) -> tid isnt taskId

    # console.log "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    # console.log "fromModuleTasksArr"
    # console.log fromModuleTasksArr
    # console.log "newFromModuleTasksArr"
    # console.log newFromModuleTasksArr

    # _newFromModuleTasksArr = []
    # _newFromModuleTasksArr.push xx for xx in newFromModuleTasksArr when xx not in _newFromModuleTasksArr

    # console.log "newFromModuleTasksArr"
    # console.log newFromModuleTasksArr
    

    # Modules.update {_id:fromModuleId}, {$set:{taskIds:_newFromModuleTasksArr}}

    # toModule = Modules.findOne _id:toModuleId
    # toModuleTasksArr = toModule.taskIds
    
    # console.log "toModuleTasksArr"
    # console.log toModuleTasksArr
    
    # toModuleTasksArr.splice toTaskPos,0,taskId
    
    # console.log "toModuleTasksArr"
    # console.log toModuleTasksArr
    
    # _toModuleTasksArr = []
    # _toModuleTasksArr.push xx for xx in toModuleTasksArr when xx not in _toModuleTasksArr
    
    # console.log "_toModuleTasksArr"
    # console.log _toModuleTasksArr
    

    # Modules.update {_id:toModuleId}, {$set:{taskIds:_toModuleTasksArr}}
    

  'deleteTask': (moduleId, taskId) ->

    user = Meteor.user()

    if !user
      throw new Meteor.Error(401, "You need to login to post new stories")

    Modules.update {
      _id: moduleId
      userId: user._id
    }, {
      $pull:
        taskIds: taskId
    }, ->
      Tasks.remove
        _id: taskId
        moduleId: moduleId
        userId: user._id

  
  # ADMIN
  'getFollowers2': (planId) ->

    user = Meteor.user()
    if !user or user.profile.email != 'waitingkuo0527@gmail.com'
      throw new Meteor.Error(401, "You need to login to post new stories")
   
    plan = Plans.findOne planId
    if plan
      if Meteor.isClient
        console.log plan.followers2
      return plan.followers2

  'setFollowers2': (planId, num) ->

    user = Meteor.user()
    if !user or user.profile.email != 'waitingkuo0527@gmail.com'
      throw new Meteor.Error(401, "You need to login to post new stories")
   
    Plans.update planId,
      $set:
        followers2: num

  'getFeatured': (planId) ->

    user = Meteor.user()
    if !user or user.profile.email != 'waitingkuo0527@gmail.com'
      throw new Meteor.Error(401, "You need to login to post new stories")
   
    plan = Plans.findOne planId
    if plan
      if Meteor.isClient
        console.log plan.featured
      return plan.featured

  'setFeatured': (planId, num) ->

    user = Meteor.user()
    if !user or user.profile.email != 'waitingkuo0527@gmail.com'
      throw new Meteor.Error(401, "You need to login to post new stories")
   
    Plans.update planId,
      $set:
        featured: num
