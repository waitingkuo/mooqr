Router.configure
  layoutTemplate: 'layout'
  waitOn: ->
    Meteor.subscribe 'userPlans'

scrollTop = ->
  $(document).scrollTop(0)
Router.onBeforeAction scrollTop


Meteor.startup ->
  Router.map ->

    @route 'index',
      path: '/'
      template: 'index'
      layoutTemplate: 'indexLayout'
      onBeforeAction: ->
        
        if Meteor.user()
          # mixpanel.track "[test][iron-router index][onBeforeAction] Meteor.user() / go to plans"
          Router.go 'plans'

      # onAfterAction: -> 
      #   mixpanel.track "[test][iron-router index][onBeforeAction] go to home page"



    @route 'plans',
      path: '/plans',
      template: 'plans'
      data: ->
        userId = Meteor.userId()

        userPlanIds = UserPlans.find({
          userId: userId
        }).map (userPlan) -> userPlan.planId

        @subscribe('plans', userPlanIds).wait()
        @subscribe('otherPlans', userPlanIds).wait()

        ownedPlanIds = UserPlans.find({
          userId: userId
          isOwner: true
        }).map (userPlan) -> userPlan.planId

        followedPlanIds = UserPlans.find({
          userId: userId
          isOwner: false
        }).map (userPlan) -> userPlan.planId
        
        return {
          ownedPlans: ->
            Plans.find
              _id: {$in: ownedPlanIds}
          followedPlans: ->
            Plans.find
              _id: {$in: followedPlanIds}
          otherPlans: -> 
            Plans.find
              _id: {$nin: userPlanIds}
        }


    @route 'plan',
      path: '/plans/:_id',
      template: 'plan'
      action: -> 
        Session.set 'currentPlanId', @params._id
        @render()
      data: ->
        planId = @params._id
        Plans.findOne planId
      waitOn: ->
        planId = @params._id
        Meteor.subscribe 'fullPlan', planId
        Meteor.subscribe 'userTasks', planId
