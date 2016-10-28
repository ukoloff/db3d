#
# Отладка upload
#
$.up = ->
  z = new FormData f = document.forms[0]
  $.ajax
    type: f.method
    url: f.action
    data: z
    processData: false
    contentType: false
    xhr: ->
      z = $.ajaxSettings.xhr()
      z.upload.onprogress = (e)->
        console.log 'Upload', e
      z
