Template.task.events

  'click .checkbox': (e) ->

    planId = Session.get 'currentPlanId'
    taskId = @_id
    userId = Meteor.userId()

    userTask = UserTasks.findOne
                  userId: userId
                  planId: planId
                  taskId: taskId

    if userTask
      UserTasks.update userTask._id,
        $set:
          checked: not userTask.checked

    else
      UserTasks.insert
        userId: userId
        planId: planId
        taskId: taskId
        checked: true


Template.task.helpers
  
  isOwner: ->
    Meteor.userId() is @userId

  isUserTask: ->
    UserPlans.findOne planId: @planId

  checked: ->

    taskId = @_id
    userId = Meteor.userId()

    userTask = UserTasks.findOne
                  userId: userId
                  taskId: taskId

    if userTask
      return userTask.checked
    else
      return undefined

