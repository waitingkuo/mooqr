Template.inputTextarea.events

  #'keydown': (e) ->
  #  $area = $(e.target)
  #  height = parseInt $area.css('height')
  #  scrollHeight = $area.prop 'scrollHeight'
  #  console.log height, scrollHeight
  #  if height+20+24 == scrollHeight
  #    $area.css 'height', height+24
  #    console.log 'setting'

Template.inputTextarea.rendered = ->
  $(@.find('textarea')).autosize()
