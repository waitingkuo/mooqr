Template.progress.helpers

  percentage: -> 
    if not Router.current().data()
      return  '0%'
    planId = Router.current().data()._id
    modules = Modules.find({planId: planId})

    # TO make reactivity FIXME
    UserTasks.find({planId: planId}).fetch()

    totalModules = modules.count()
    finishedModules = 0
    for module in modules.fetch()
      totalTasks = module.taskIds.length
      if totalTasks is 0
        totalModules -= 1
      else
        finishedTasks = UserTasks.find({
          taskId: {$in: module.taskIds},
          checked: true,
        }).count()
        finishedModules += finishedTasks / totalTasks

    if totalModules is 0
      return '0%'
    else
      return numeral(finishedModules / totalModules).format('0%')



Template.plan.helpers

  isOwner: () ->
    Meteor.userId() is @userId

  modules: ->
    @moduleIds?.map (moduleId) -> Modules.findOne moduleId

  planMenuData: ->
    items: [
      {
        label: 'Add Module'
        clickEvent: (e) =>
          planId = @_id
          Session.set 'currentPlanId', planId
          Blaze.render Template.moduleDialog, document.body
      },
      {
        label: 'Edit'
        clickEvent: (e) ->
          Blaze.render Template.editPlanDialog, document.body
      }
    ]


  

  
