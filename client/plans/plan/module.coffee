

Template.module.helpers

  isOwner: () ->
    Meteor.userId() is @userId

  isContent: ->
   @moduleLink? or @moduleDescription?

  tasks: ->
    @taskIds?.map (taskId) -> Tasks.findOne taskId

  moduleMenuData: ->
    items: [
      {
        label: 'Edit Module'
        clickEvent: (e) =>
          moduleId = @_id
          Session.set 'currentModuleId', moduleId
          Blaze.render Template.editModuleDialog, document.body
      }
      {
        label: 'Remove Module'
        clickEvent: (e) =>
          planId = Session.get 'currentPlanId'
          moduleId = @_id
          Meteor.call 'deleteModule', planId, moduleId
      }
      {
        label: 'Add Task'
        clickEvent: (e) =>
          moduleId = @_id
          Session.set 'currentModuleId', moduleId
          Blaze.render Template.taskDialog, document.body
      }
    ]



# Template.module.rendered = -> 
  # $( ".tasks" ).sortable
  #   items: ">.task"
  #   connectWith: ".tasks"
  #   stop: (event, ui) ->
  #     el = ui.item.get 0
  #     taskId = el.id
  #     moveToModuleId = $(el).parent().parent().parent()[0].id
  #     fromModuleId = Tasks.findOne({_id:taskId}).moduleId
  #     tasksArray = $("#"+moveToModuleId+" .task").map -> @id
  #     tasksArray = tasksArray.toArray()
  #     moveToPos = tasksArray.indexOf taskId


  #     Meteor.call "moveTask", taskId, fromModuleId, moveToModuleId, moveToPos, (err, result) ->
  #       if not err
  #         "moveTask successfully!"
          
  #         # # console.log "moveTask successfully!"
  #         # _tasksArray = $("#"+moveToModuleId+" .task").map -> @id
  #         # _tasksArray = _tasksArray.toArray()

  #         # # console.log "tasksArray"
  #         # # console.log tasksArray
  #         # # console.log "_tasksArray"
  #         # # console.log _tasksArray
  #         # # console.log _tasksArray.length > tasksArray.length
  #         # # console.log Modules.findOne _id:moveToModuleId

  #         # if _tasksArray.length > tasksArray.length
  #         #   # console.log "EXEC _tasksArray.length > tasksArray.length"
  #         #   $(el).remove()

  #         # if _tasksArray.length < tasksArray.length
  #         #   # console.log "EXEC _tasksArray.length > tasksArray.length"
  #         #   # console.log $(el)
  #         #   tasks = $("#"+moveToModuleId+" .tasks .task")
  #         #   # console.log tasks.length
  #         #   # console.log moveToPos
  #         #   if moveToPos > 0
  #         #     # console.log $("#"+moveToModuleId+" .tasks .task")[moveToPos-1]
  #         #     $($("#"+moveToModuleId+" .tasks .task")[moveToPos-1]).after(el)
  #         #   else
  #         #     $($("#"+moveToModuleId+" .tasks .task")[0]).before(el)
              

  #         #   # $(el).appendTo()
  #         #   # $("#"+moveToModuleId+" .task:eq("+moveToPos+")").after $(el)

  #       else
  #         if err.error is 402
  #           Snackbars.popup "Cannot move task. (NOT PLAN OWNER!)"


  #     # console.log "~~~~~~~~~~~~~"
  #     # console.log "taskId"
  #     # console.log taskId
  #     # console.log "moveToModuleId"
  #     # console.log moveToModuleId
  #     # console.log "fromModuleId"
  #     # console.log fromModuleId
  #     # console.log "moveToPos"
  #     # console.log moveToPos



      
