Template.task.events

  'click .edit-task': (e) ->
    Session.set 'currentTaskId', @_id
    Blaze.render Template.editTaskDialog, document.body

  'click .delete-task': (e) ->
    Meteor.call 'deleteTask', @moduleId, @_id, (err, result) ->
      if not err
        Snackbars.popup 'Task has been deleted successfully'

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
  hasYoutubeVideo: ->
    if @youtubeVideoId
      true
    else
      false
  
  isOwner: ->
    Meteor.userId() is @userId

  isUserTask: ->
    UserPlans.findOne planId: @planId

  checked: ->

    if not UserPlans.findOne({planId: @planId})
      return undefined

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
  planId = Session.get('currentPlanId')
  plan = Plans.findOne(planId)
  if not Meteor.userId()?
    return
  if plan?.userId isnt Meteor.userId()
    return

  $('.task').addClass 'dragable'

  $( ".tasks" ).sortable
    items: ">.task"
    connectWith: ".tasks"
    stop: (event, ui) ->
      el = ui.item.get 0
      taskId = el.id
      moveToModuleId = $(el).parent().parent().parent()[0].id
      fromModuleId = Tasks.findOne({_id:taskId}).moduleId
      tasksArray = $("#"+moveToModuleId+" .task").map -> @id
      tasksArray = tasksArray.toArray()
      moveToPos = tasksArray.indexOf taskId


      Meteor.call "moveTask", taskId, fromModuleId, moveToModuleId, moveToPos, (err, result) ->
        if not err
          "moveTask successfully!"
          
          # # console.log "moveTask successfully!"
          # _tasksArray = $("#"+moveToModuleId+" .task").map -> @id
          # _tasksArray = _tasksArray.toArray()

          # # console.log "tasksArray"
          # # console.log tasksArray
          # # console.log "_tasksArray"
          # # console.log _tasksArray
          # # console.log _tasksArray.length > tasksArray.length
          # # console.log Modules.findOne _id:moveToModuleId

          # if _tasksArray.length > tasksArray.length
          #   # console.log "EXEC _tasksArray.length > tasksArray.length"
          #   $(el).remove()

          # if _tasksArray.length < tasksArray.length
          #   # console.log "EXEC _tasksArray.length > tasksArray.length"
          #   # console.log $(el)
          #   tasks = $("#"+moveToModuleId+" .tasks .task")
          #   # console.log tasks.length
          #   # console.log moveToPos
          #   if moveToPos > 0
          #     # console.log $("#"+moveToModuleId+" .tasks .task")[moveToPos-1]
          #     $($("#"+moveToModuleId+" .tasks .task")[moveToPos-1]).after(el)
          #   else
          #     $($("#"+moveToModuleId+" .tasks .task")[0]).before(el)
              

          #   # $(el).appendTo()
          #   # $("#"+moveToModuleId+" .task:eq("+moveToPos+")").after $(el)

        else
          if err.error is 402
            Snackbars.popup "Cannot move task. (NOT PLAN OWNER!)"


      # console.log "~~~~~~~~~~~~~"
      # console.log "taskId"
      # console.log taskId
      # console.log "moveToModuleId"
      # console.log moveToModuleId
      # console.log "fromModuleId"
      # console.log fromModuleId
      # console.log "moveToPos"
      # console.log moveToPos


#   $( ".tasks" ).sortable
#     revert:true
#     items: ".task" 
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

  
