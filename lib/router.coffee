Router.configure
  layoutTemplate: 'layout'
  waitOn: ->
    Meteor.subscribe 'userPlans'

scrollTop = ->
  $(document).scrollTop(0)
Router.onBeforeAction scrollTop


Meteor.startup ->

  if Meteor.isClient
    if Meteor.settings?.public?.mixpanel?.token?
      mixpanel.init Meteor.settings.public.mixpanel.token
    else
      mixpanel.init('NO_TOKEN')
      console.log 'mixpanel init failed'

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
              deleted: false
          followedPlans: ->
            Plans.find
              _id: {$in: followedPlanIds}
              deleted: false
          otherPlans: ->
            Plans.find
              _id: {$nin: userPlanIds}
              deleted: false
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
      


