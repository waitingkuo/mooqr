@UserTasks = new Meteor.Collection 'userTasks'

UserTasks.attachSchema new SimpleSchema

  userId:
    type: String
    label: 'User ID'

  planId:
    type: String
    label: 'Plan ID'

  taskId:
    type: String
    label: 'Task ID'

  checked:
    type: Boolean
    label: 'Checked'

UserTasks.allow

  insert: (userId, doc) -> not not userId
  update: (userId, doc) -> userId is doc.userId
