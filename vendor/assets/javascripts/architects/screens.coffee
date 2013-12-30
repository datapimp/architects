Architects.screens = {}

Architects.screens.show = ->

  hljs.initHighlightingOnLoad()

  $('#tabs a').click (e)->
    e.preventDefault()
    $(this).tab('show')

  $('#annotations').addClass('active in')
  $('#tabs li.toggle.annotations').eq(0).addClass('active')

  $('#tabs li.toggle.acceptance-criteria, #tabs li.toggle.data-sources').click(disableAnnotations)
  $('#tabs li.toggle.annotations').click(enableAnnotations)

  enableAnnotations()
  setupCarousel()


setupCarousel = ->
  unless hasMultipleImages()
    $('.carousel-indicators').hide()
    $('.carousel-control').hide()

    return

  carousel = $('.screen-image.carousel').carousel(interval:5000)

  $('#annotations .annotation').click (e)->
    $target = $(e.currentTarget)
    images = $('.carousel-inner .item').map (i,e)->
      $(e).attr('data-image')
    index = images.toArray().indexOf($target.attr('data-image'))
    carousel.carousel(index)



hasMultipleImages = ->
  $('#image-carousel[data-multiple]').length > 0

enableAnnotations = ->
  $('.annotation-anchors').addClass('annotations-enabled')

disableAnnotations = ->
  $('.annotation-anchors').removeClass('annotations-enabled')

