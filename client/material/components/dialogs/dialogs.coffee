Template.inputTextarea.events

  'keyup': (e) ->
    $area = $(e.target)
    $area.css 'height', '0'
    scrollHeight = $area.prop('scrollHeight') - 20
    console.log scrollHeight
    $area.css 'height', scrollHeight

