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
  userPlans = UserPlans.find({userId: userId})
  planIds = _.map userPlans.fetch(), (userPlan) -> userPlan.planId

  return [
    userPlans
    Plans.find
      _id:
        $in: planIds
  ]


Meteor.publish 'otherPlans', () ->

  userId = @userId

  Plans.find
    userId:
      $ne: userId
    




