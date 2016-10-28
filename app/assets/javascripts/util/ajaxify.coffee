###
Submit form via AJAX
###
$.fn.ajaxify = ->
  return @ if 'function' != typeof FormData
  @.submit ->
    $ '.modal'
    .modal()
    false
  @
