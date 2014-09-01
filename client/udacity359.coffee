Meteor.startup ->
  Template.udacity359.helpers

    percent: ->

      return 0
      #FIXME
      if Router.current().data()
        finishedModules = 0

        #console.log Router.current().data()
        modules = Router.current().data().modules
        numOfModules = modules.length

        for module in modules
          numOfTasks = module.tasks.length
          finishedTasks = _.reduce module.tasks, ((p, task) -> p + task.done), 0
          finishedModules += finishedTasks / numOfTasks


        percent = numeral(finishedModules / numOfModules).format('0.0%')
        percent


  Template.udacity359.events

    'click .task': (e) ->
      coursePlanId = Router.current().data()._id
      taskId = @taskId
      #done = not @done
      #Meteor.call 'updateCoursePlanTask', coursePlanId, taskId, done
      console.log consolePlanId
