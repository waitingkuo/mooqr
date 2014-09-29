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


Template.task.rendered = ->
  @$( ".tasks" ).sortable
    revert:true
    items: ".task" 
    # stop: (event, ui) ->
    #   el = ui.item.get 0

    #   # console.log $(@).sortable( "toArray" )
    #   # console.log el.id
    #   # console.log $(@).sortable( "toArray" ).indexOf el.id
    #   planId = Router.current().data()._id
    #   moduleId = el.id
    #   newPosition = $(@).sortable( "toArray" ).indexOf moduleId
      
    #   # console.log "planId:"
    #   # console.log planId

    #   Meteor.call "moveModule", planId, moduleId, newPosition, (err, result) ->
    #     if not err
    #       "moveModule successfully!"
    #       # console.log "moveModule successfully!"
    #     else
    #       if err.error is 402
    #         Snackbars.popup "Cannot move module. (NOT OWNER!)"

  