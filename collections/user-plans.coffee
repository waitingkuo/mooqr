@UserPlans = new Meteor.Collection 'userPlans'

UserPlans.attachSchema new SimpleSchema

  userId:
    type: String
    label: 'User ID'

  planId:
    type: String
    label: 'Plan ID'

  isOwner:
    type: Boolean
    label: 'Is Owner'
    

UserPlans.allow

  insert: -> true
  update: -> true

