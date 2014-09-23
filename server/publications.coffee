#
# Resource   : fullPlans
# Collections: Plans + Modules + Tasks
#
Meteor.publish 'fullPlan', (planId) ->
  [
    Plans.find
      _id: planId
    Modules.find
      planId: planId
    Tasks.find
      planId: planId
  ]


#
# Resource   : plans
# Collections: Plans
#
Meteor.publish 'plans', (planIds) ->
  Plans.find
    _id: {$in: planIds}

Meteor.publish 'otherPlans', (notPlanIds) ->
  Plans.find({
    _id: {$nin: notPlanIds}
  }, {
    limit: 25
  })



#
# Resource   : userPlans 
# Collections: UserPlans
#
Meteor.publish 'userPlans', () ->
  
  userId = @userId
  UserPlans.find
    userId: userId


#
# Resource   : userTasks
# Collections: UserTasks
#
Meteor.publish 'userTasks', (planId) ->

  userId = @userId
  UserTasks.find
    userId: userId
    planId: planId






    
Meteor.publish 'allPlans', () ->
  Plans.find()
    





