Meteor.publish 'plan', (planId) ->

  # FIXME currently we allow all users to see the plans
  #userId = @userId

  [
    Plans.find
      _id: planId
      #userId: userId
    Modules.find
      planId: planId
      #userId: userId
    Tasks.find
      planId: planId
      #userId: userId
  ]


Meteor.publish 'userPlans', () ->

  userId = @userId
  
  console.log "userId = "
  console.log userId
  console.log @
  
  # console.log "user._id = "
  # console.log Meteor.userId()
  
  # userId = user._id

  userPlans = UserPlans.find({userId: userId})
  planIds = _.map userPlans.fetch(), (userPlan) -> userPlan.planId

  return [
    userPlans
    Plans.find
      _id:
        $in: planIds
  ]

Meteor.publish 'userTasks', (planId) ->

  userId = @userId

  UserTasks.find
    userId: userId
    planId: planId


Meteor.publish 'otherPlans', () ->

  userId = @userId

  Plans.find
    userId:
      $ne: userId


    
Meteor.publish 'allPlans', () ->
  Plans.find()
    


Meteor.publish 'userPlansNew', () ->

  userId = @userId
  
  userPlans = UserPlans.find({userId: userId})
  planIds = _.map userPlans.fetch(), (userPlan) -> userPlan.planId

  return userPlans.find({userId: userId})





