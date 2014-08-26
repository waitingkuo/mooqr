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
        modules: -> [
          {
            moduleName: 'Module 1'
            tasks: [
              {
                taskName: 'Lesson 1 - Introduction'
                done: true
              }
              {
                taskName: 'Project 1 - Titanic'
                done: false
              }
            ]
          }
          {
            moduleName: 'Module 2'
            tasks: [
              {
                taskName: 'Lesson 2 - woo'
                done: false
              }
              {
                taskName: 'Project 2 - woo'
                done: false
              }
            ]
          }
        ]

