#FIXME should add a method to set admin rule
#userId = 'QnXjhDaqe72o8MTFg'
#user = Meteor.users.findOne userId

# Sample code to add a user as a admin
#if user and not Roles.userIsInRole(userId, ['admin'])
#  console.log 'adding ' + user.name + ' as a admin'
#  Roles.addUsersToRoles userId, ['admin']

# Sample Codes to add a user as a leader of the group 'woo'
#if user and not Roles.userIsInRole(userId, ['leader'], 'woo')
#  console.log 'adding ' + user.name + ' as a leader of ' + 'woo'
#  Roles.addUsersToRoles userId, ['leader'], 'woo'
#
