#
# Resource   : fullPlans
# Collections: Plans + Modules + Tasks
#
Meteor.publish 'fullPlan', (planId) ->
  [
    Plans.find
      _id: planId
    Modules.find
      planId: planId
    Tasks.find
      planId: planId
  ]


#
# Resource   : plans
# Collections: Plans
#
Meteor.publish 'plans', (planIds, searchWords) ->
  stoppingWords = ['i', 'me', 'my', 'myself', 'we', 'our', 'ours', 'ourselves', 'you', 'your', 'yours', 'yourself', 'yourselves', 'he', 'him', 'his', 'himself', 'she', 'her', 'hers', 'herself', 'it', 'its', 'itself', 'they', 'them', 'their', 'theirs', 'themselves', 'what', 'which', 'who', 'whom', 'this', 'that', 'these', 'those', 'am', 'is', 'are', 'was', 'were', 'be', 'been', 'being', 'have', 'has', 'had', 'having', 'do', 'does', 'did', 'doing', 'a', 'an', 'the', 'and', 'but', 'if', 'or', 'because', 'as', 'until', 'while', 'of', 'at', 'by', 'for', 'with', 'about', 'against', 'between', 'into', 'through', 'during', 'before', 'after', 'above', 'below', 'to', 'from', 'up', 'down', 'in', 'out', 'on', 'off', 'over', 'under', 'again', 'further', 'then', 'once', 'here', 'there', 'when', 'where', 'why', 'how', 'all', 'any', 'both', 'each', 'few', 'more', 'most', 'other', 'some', 'such', 'no', 'nor', 'not', 'only', 'own', 'same', 'so', 'than', 'too', 'very', 's', 't', 'can', 'will', 'just', 'don', 'should', 'now']
  searchWordsArray = searchWords.split("|").map((xx) -> xx.toLowerCase()).filter (word)-> word not in stoppingWords
  _searchWords = searchWordsArray.join("|")
  # console.log "__searchWord"  
  # console.log __searchWord

  Plans.find
    _id: {$in: planIds}
    planName: {
      $regex: _searchWords,
      $options: "i"
    }


Meteor.publish 'otherPlans', (notPlanIds, searchWords) ->
  stoppingWords = ['i', 'me', 'my', 'myself', 'we', 'our', 'ours', 'ourselves', 'you', 'your', 'yours', 'yourself', 'yourselves', 'he', 'him', 'his', 'himself', 'she', 'her', 'hers', 'herself', 'it', 'its', 'itself', 'they', 'them', 'their', 'theirs', 'themselves', 'what', 'which', 'who', 'whom', 'this', 'that', 'these', 'those', 'am', 'is', 'are', 'was', 'were', 'be', 'been', 'being', 'have', 'has', 'had', 'having', 'do', 'does', 'did', 'doing', 'a', 'an', 'the', 'and', 'but', 'if', 'or', 'because', 'as', 'until', 'while', 'of', 'at', 'by', 'for', 'with', 'about', 'against', 'between', 'into', 'through', 'during', 'before', 'after', 'above', 'below', 'to', 'from', 'up', 'down', 'in', 'out', 'on', 'off', 'over', 'under', 'again', 'further', 'then', 'once', 'here', 'there', 'when', 'where', 'why', 'how', 'all', 'any', 'both', 'each', 'few', 'more', 'most', 'other', 'some', 'such', 'no', 'nor', 'not', 'only', 'own', 'same', 'so', 'than', 'too', 'very', 's', 't', 'can', 'will', 'just', 'don', 'should', 'now']
  searchWordsArray = searchWords.split("|").map((xx) -> xx.toLowerCase()).filter (word)-> word not in stoppingWords
  _searchWords = searchWordsArray.join("|")

  Plans.find({
    _id: {$nin: notPlanIds}
    planName: {
      $regex: _searchWords,
      $options: "i"
    }
  }, {
    limit: 25
    sort:
      featured: -1
  })



#
# Resource   : userPlans 
# Collections: UserPlans
#
Meteor.publish 'userPlans', () ->
  
  userId = @userId
  UserPlans.find
    userId: userId


#
# Resource   : userTasks
# Collections: UserTasks
#
Meteor.publish 'userTasks', (planId) ->

  userId = @userId
  UserTasks.find
    userId: userId
    planId: planId

    
Meteor.publish 'allPlans', () ->
  Plans.find()
    





