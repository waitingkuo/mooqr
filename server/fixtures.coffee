Meteor.methods
  # a temporary function
  'initData': -> 
    if Meteor.isServer
      Plans.remove()
      Modules.remove()
      Tasks.remove()

    planId = Meteor.call 'createPlan', 'Plan 1'
    moduleId1 = Meteor.call 'addModule', planId, 'Module 1'
    Meteor.call 'addTask', planId, moduleId1, 'Task 1 - a'
    Meteor.call 'addTask', planId, moduleId1, 'Task 1 - b'
    Meteor.call 'addTask', planId, moduleId1, 'Task 1 - c'

    moduleId2 = Meteor.call 'addModule', planId, 'Module 2'
    Meteor.call 'addTask', planId, moduleId2, 'Task 1 - a'
    Meteor.call 'addTask', planId, moduleId2, 'Task 2 - b'
    Meteor.call 'addTask', planId, moduleId2, 'Task 3 - c'

    moduleId3 = Meteor.call 'addModule', planId, 'Module 3'
    Meteor.call 'addTask', planId, moduleId3, 'Task 1 - a'
    Meteor.call 'addTask', planId, moduleId3, 'Task 2 - b'
    Meteor.call 'addTask', planId, moduleId3, 'Task 3 - c'


#if CoursePlans.find().count() is 0

  # Should be moved to test case
  # Create a new coursePlan
  #plan =
  #  courseId: 'FIXME'
  #  courseName: 'Udacity 359 - Introduction to Data Science'
  #  moduleSeq: 0
  #  modules: []
  #plan._id = CoursePlans.insert plan


  # Add a module
  #seq = CoursePlans.findOne(plan._id).moduleSeq + 1
  #CoursePlans.update plan._id,
  #  $push:
  #    modules:
  #      moduleName: 'Module 1'
  

  # Add 3 tasks
  #task =
  #  taskName: 'Lesson 1'
  #  link: 'www.google.com'
  #task._id = Tasks.insert task
  #CoursePlans.update plan._id,


  #tasks = [1..7].map (num) ->
  #  task =
  #    taskName: 'Lesson ' + num
  #    link: 'www.google.com'
  #  task._id = Tasks.insert task 
  #  return task
  #
  #CoursePlans.insert
  #  courseName: 'Udacity 359 - Introduction to Data Science'
  #  modules: []
  #
  #
  #CoursePlans.update(
  #    {
  #      moduleName: 'Module 1'
  #      taskIds: [tasks[0]._id, tasks[1]._id, tasks[2]._id]
  #    }
  #    {
  #      moduleName: 'Module 2'
  #      taskIds: [tasks[3]._id, tasks[4]._id]
  #    }
  #    {
  #      moduleName: 'Module 3'
  #      taskIds: [tasks[5]._id, tasks[6]._id]
  #    }
  #  ]
  #
  #
  #
