Router.configure
  layoutTemplate: 'layout'
  waitOn: ->
    Meteor.subscribe 'userPlans'
    mixpanel.init "696a8c98c250f36f66eb4aab990f79a0"
      

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
          Router.go 'plans'

      onAfterAction: ->
        user = Meteor.user()
        if user
          Router.go 'plans'
          mixpanel.identify user._id
          mixpanel.people.set
            "$email": user.profile.email
      
          mixpanel.track "[test][UserView] index redirectTo plans"
        else
          mixpanel.track "[test][AnonymousUserView] index"



    @route 'plans',
      path: '/plans',
      template: 'plans'
      data: ->
        userId = Meteor.userId()

        userPlanIds = UserPlans.find({
          userId: userId
        }).map (userPlan) -> userPlan.planId



        searchWords = Session.get("searchWords")
        if searchWords
          @subscribe('plans', userPlanIds, searchWords).wait()
          @subscribe('otherPlans', userPlanIds, searchWords).wait()
          
        else
          Session.setDefault("searchWords",".*")
          searchWords = Session.get("searchWords")
          @subscribe('plans', userPlanIds, searchWords).wait()
          @subscribe('otherPlans', userPlanIds, searchWords).wait()

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


      onAfterAction: -> 
        user = Meteor.user()
        if user
          mixpanel.track "[test][UserView] plans"
        else
          mixpanel.track "[test][AnonymousUserView] plans"



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

      onAfterAction: -> 
        planId = @params._id
        user = Meteor.user()
        if user
          mixpanel.track "[test][UserViewPlan] planId:" + planId
        else
          mixpanel.track "[test][AnonymousUserViewPlan] planId:" + planId
      


