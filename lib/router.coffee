Router.configure
  layoutTemplate: 'layout'

scrollTop = ->
  $(document).scrollTop(0)
Router.onBeforeAction scrollTop


Meteor.startup ->
  Router.map ->

    @route 'test66',
      path: '/test66'
      template: 'test66'

    @route 'index',
      path: '/'
      template: 'index'
      layoutTemplate: 'indexLayout'
      onBeforeAction: ->
        if Meteor.user()
          Router.go 'plans'

    @route 'plans',
      path: '/plans',
      template: 'plans'
      data: ->
        # FIXME according to user
        plans: ->
          userPlans = UserPlans.find
            userId: Meteor.userId()
            isOwner: true

          planIds = userPlans.map (userPlan) -> userPlan.planId

          Plans.find
            _id:
              $in: planIds

        followedPlans: ->
          userPlans = UserPlans.find
            userId: Meteor.userId()
            isOwner: false

          planIds = userPlans.map (userPlan) -> userPlan.planId

          Plans.find
            _id:
              $in: planIds

        otherPlans: ->
          userPlans = UserPlans.find
            userId: Meteor.userId()

          planIds = userPlans.map (userPlan) -> userPlan.planId

          #FIX bad performance
          Plans.find
            _id:
              $nin: planIds


      waitOn: ->
        Meteor.subscribe 'userPlans'
        # Meteor.subscribe 'otherPlans'
        # Meteor.subscribe 'userPlansNew'
        Meteor.subscribe 'allPlans'

        


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
        if plan and plan.moduleIds
          plan.modules = plan.moduleIds.map (moduleId) -> 
            module = Modules.findOne moduleId
            if module and module.taskIds
              module.tasks = module.taskIds.map (taskId) ->
                Tasks.findOne taskId
            module
          

        plan

      waitOn: ->
        planId = @params._id
        Meteor.subscribe 'plan', planId
        Meteor.subscribe 'userTasks', planId
      

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

