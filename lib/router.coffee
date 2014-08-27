Router.configure
  layoutTemplate: 'layout'

Meteor.startup ->
  Router.map ->

    @route 'index',
      path: '/'
      template: 'index'

    @route 'udacity359',
      path: '/udacity359'
      template: 'udacity359'
      data: ->
        # FIXME
        CoursePlans.findOne()
      waitOn: ->
        Meteor.subscribe 'coursePlans'
