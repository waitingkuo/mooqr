Router.configure
  layoutTemplate: 'layout'

Meteor.startup ->
  Router.map ->

    @route 'index',
      path: '/'
      template: 'index'

    @route 'plans',
      path: '/plans',
      template: 'plans'
      data: ->
        # FIXME according to user
        plans: -> Plans.find()
      waitOn: ->
        Meteor.subscribe 'userPlans'

    @route 'plan',
      path: '/plans/:_id',
      template: 'plan'
      action: -> 
        Session.set 'currentPlanId', @params._id
        @render()
      data: ->
        # FIXME might need to optimize
        planId = @params._id
        plan = Plans.findOne @params._id
        if plan
          plan.modules = plan.moduleIds.map (moduleId) -> 
            module = Modules.findOne moduleId
            if module.taskIds
              module.tasks = module.taskIds.map (taskId) ->
                Tasks.findOne taskId
            module
          

        plan

      waitOn: ->
        planId = @params._id
        Meteor.subscribe 'plan', planId
      

    @route 'udacity359',
      path: '/udacity359'
      template: 'udacity359'
      waitOn: ->
        # FIXME Should query by userId
        Meteor.subscribe 'coursePlans'
      data: ->
        plan = CoursePlans.findOne()
        #taskIds = _.flatten plan.modules.map( (m) -> m.taskIds )
        if plan
          for module in plan.modules
            module.tasks = Tasks.find(_id: {$in: module.taskIds}).fetch()
        console.log plan
        return plan

