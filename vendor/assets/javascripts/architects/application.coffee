#= require_self
#= require_tree .
window.Architects ||= {}

Architects.onReady = ->
  controller = $('body').attr('data-controller')
  action = $('body').attr('data-action')

  Architects[controller]?[action]?.call(this)

$(Architects.onReady)
