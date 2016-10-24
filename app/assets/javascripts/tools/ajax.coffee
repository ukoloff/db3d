#
# Отладка upload
#
$.up = ->
  z = new FormData f = document.forms[0]
  z.append 'ajax', true
  $.ajax
    type: 'put'
    url: f.action
    data: z
    processData: false
    contentType: false
