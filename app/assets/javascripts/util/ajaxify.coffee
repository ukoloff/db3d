###
Submit form via AJAX
###
$.fn.ajaxify = ->
  return @ if 'function' != typeof FormData
  @.submit ->
    modal = $ '.modal'
    .one 'shown.bs.modal', =>
      $.ajax
        type: @method
        url: @action
        data: new FormData @
        processData: false
        contentType: false
        xhr: ->
          z = $.ajaxSettings.xhr()
          z.upload.onprogress = (e)->
            console.log 'Upload', e
          z
      .always ->
        modal.modal 'hide'
      .done (data)->
        console.log data
      .fail ->
        console.error "Oops!"
    .one 'hide.bs.modal', ->
      0
    .modal()
    false
  @
