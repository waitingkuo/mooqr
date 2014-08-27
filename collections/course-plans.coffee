@CoursePlans = new Meteor.Collection 'coursePlans'

if CoursePlans.find().count() is 0

  CoursePlans.insert
    courseName: 'Udacity 359 - Introduction to Data Science'
    modules: [
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
      {
        moduleName: 'Module 3'
        tasks: [
          {
            taskName: 'Lesson 3 - woo'
            done: false
          }
          {
            taskName: 'Lesson 3.1 - woo'
            done: false
          }
          {
            taskName: 'Project 3.2 - woo'
            done: true
          }
        ]
      }
    ]


