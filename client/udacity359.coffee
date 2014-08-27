Meteor.startup ->
  Template.udacity359.helpers

    percent: ->

      finishedModules = 0

      modules = Router.current().data().modules
      numOfModules = modules.length

      for module in modules
        numOfTasks = module.tasks.length
        finishedTasks = _.reduce module.tasks, ((p, task) -> p + task.done), 0
        finishedModules += finishedTasks / numOfTasks

      numeral(finishedModules / numOfModules).format('0.0%')

