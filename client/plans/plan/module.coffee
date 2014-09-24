Template.module.helpers

  isOwner: () ->
    Meteor.userId() is @userId

  tasks: ->
    @taskIds?.map (taskId) -> Tasks.findOne taskId

  moduleMenuData: ->
    items: [
      {
        label: 'Add Task'
        clickEvent: (e) =>
          moduleId = @_id
          Session.set 'currentModuleId', moduleId
          Blaze.render Template.taskDialog, document.body
      },
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
    ]
