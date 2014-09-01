Meteor.publish 'coursePlan', ->
  # should be para
  coursePlanId = CoursePlans.findOne()._id
  [
    CoursePlans.find(coursePlanId)
    Tasks.find()
  ]

Meteor.publish 'plan', (planId) ->
  [
    Plans.find planId
    Modules.find planId: planId
    Tasks.find planId: planId
  ]




