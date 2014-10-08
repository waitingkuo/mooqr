Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  waitOn: ->
    Meteor.subscribe 'userPlans'

#Router.onBeforeAction('loading')

Router.onAfterAction ->
    Tracker.nonreactive =>
      GAnalytics.pageview @path

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
      data:
        plans: ->
          Plans.find({
            deleted: false
          },{
            limit: 3
            sort:
              featured: -1
          })
      waitOn: ->
        Meteor.subscribe 'featuredPlans'

      onAfterAction: ->
        user = Meteor.user()
        if user
          mixpanel.identify user._id
          mixpanel.people.set
            "$email": user.profile.email
      
          mixpanel.track "[UserView] index redirectTo plans"
          
          Router.go 'plans'
          
        else
          mixpanel.track "[AnonymousUserView] index"



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
            Plans.find({
              _id: {$nin: userPlanIds}
              deleted: false
            },{
              sort:
                featured: -1
            })
        }


      onAfterAction: -> 
        
        user = Meteor.user()
        if user
          
          mixpanel.identify user._id
          mixpanel.people.set
            "$email": user.profile.email
          mixpanel.track "[UserView] plans"
        else
          mixpanel.track "[AnonymousUserView] plans"



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
          
          mixpanel.identify user._id
          mixpanel.people.set
            "$email": user.profile.email
          mixpanel.track "[UserViewPlan] planId:" + planId
        else
          mixpanel.track "[AnonymousUserViewPlan] planId:" + planId
      


