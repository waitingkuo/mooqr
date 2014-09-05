Meteor.publish 'plan', (planId) ->

  userId = @userId

  [
    Plans.find
      _id: planId
      userId: userId
    Modules.find
      planId: planId
      userId: userId
    Tasks.find
      planId: planId
      userId: userId
  ]

Meteor.publish 'userPlans', () ->

  userId = @userId

  Plans.find
    userId: userId
    



