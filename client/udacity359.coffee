Meteor.startup ->
  Template.udacity359.helpers

    percent: ->

      finishedModules = 0

      modules = Router.current().data()
      numOfModules = modules.length

      for module in modules
        numOfTasks = module.tasks.length
        finishedTasks = _.reduce module.tasks, ((p, task) -> p + task.done), 0
        finishedModules += finishedTasks / numOfTasks

      100 * finishedModules / numOfModules

    courseName: -> 'Udacity 359 - Introduction to Data Science'
