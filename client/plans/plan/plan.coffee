


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
      if totalTasks isnt 0
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

  isFollowed: () ->
    UserPlans.findOne({
      planId: @_id
      isOwner: false
    })?

  isContent: ->
    @planLink? or @planDescription?

  isUserPlan: () ->
    UserPlans.findOne planId: @_id

  modules: ->
    @moduleIds?.map (moduleId) -> Modules.findOne moduleId

  planMenuData: ->
    items: [
      {
        label: 'Edit Plan'
        clickEvent: (e) =>
          Session.set 'currentPlanId', @_id
          Blaze.render Template.editPlanDialog, document.body
      }
      {
        label: 'Add Module'
        clickEvent: (e) =>
          planId = @_id
          Session.set 'currentPlanId', planId
          Blaze.render Template.moduleDialog, document.body
      },
    ]

Template.plan.events
  
  'click .follow': (e) ->
    e.stopPropagation()

    planId = @_id

    Meteor.call 'followPlan', planId, (err, result) ->
      console.log "user follow plan: "
      console.log result
      if result.status is "success"
        mixpanel.track result.mixpanel


  'click .unfollow': (e) ->
    e.stopPropagation()

    planId = @_id

    Meteor.call 'unfollowPlan', planId, (err, result) ->
      console.log "user unfollow plan: "
      console.log result
      if result.status is "success"
        mixpanel.track result.mixpanel
  

Template.plan.rendered = ->

  @$( ".sortableData" ).sortable
    revert:true
    items: " > div.sortable-module"
    stop: (event, ui) ->
      el = ui.item.get 0

      # console.log $(@).sortable( "toArray" )
      # console.log el.id
      # console.log $(@).sortable( "toArray" ).indexOf el.id
      planId = Router.current().data()._id
      moduleId = el.id
      newPosition = $(@).sortable( "toArray" ).indexOf moduleId
      
      # console.log "planId:"
      # console.log planId

      Meteor.call "moveModule", planId, moduleId, newPosition, (err, result) ->
        if not err
          "moveModule successfully!"
          # console.log "moveModule successfully!"
        else
          if err.error is 402
            Snackbars.popup "Cannot move module. (NOT PLAN OWNER!)"

  @$( ".sortableData" ).disableSelection()

