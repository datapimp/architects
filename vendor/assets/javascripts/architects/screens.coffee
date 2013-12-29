Architects.screens = {}
Architects.screens.show = ->
  $('#tabs a').click (e)->
    e.preventDefault()
    $(this).tab('show')

  $('#annotations').addClass('active in')
  $('#tabs li.toggle.annotations').eq(0).addClass('active')

  enableAnnotations = ->
    $('.annotation-anchors').addClass('annotations-enabled')

  disableAnnotations = ->
    $('.annotation-anchors').removeClass('annotations-enabled')

  $('#tabs li.toggle.acceptance-criteria, #tabs li.toggle.data-sources').click(disableAnnotations)
  $('#tabs li.toggle.annotations').click(enableAnnotations)

  enableAnnotations()



