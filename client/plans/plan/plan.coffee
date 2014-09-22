Template.plan.helpers

  isOwner: () ->
    Meteor.userId() is @userId

  planMenuData: ->
    items: [
      {
        label: 'Add Module'
        clickEvent: (e) =>
          planId = @_id
          Session.set 'currentPlanId', planId
          Blaze.render Template.moduleDialog, document.body
      },
      {
        label: 'Edit'
        clickEvent: (e) ->
          Blaze.render Template.editPlanDialog, document.body
      }
    ]


  

  
