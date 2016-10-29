###
Submit form via AJAX
###
$.fn.ajaxify = ->
  return @ if 'function' != typeof FormData
  @.submit ->
    xhr = 0
    modal = $ '.modal'
    .one 'shown.bs.modal', =>
      xhr = $.ajax
        type: @method
        url: @action
        data: new FormData @
        processData: false
        contentType: false
        xhr: ->
          z = $.ajaxSettings.xhr()
          z.upload.onprogress = (e)->
            progress.css width: "#{e.loaded / e.total * 100}%"
          z
      .always ->
        xhr = 0
        modal.modal 'hide'
      .done (data)->
        location.href = data.path
      .fail ->
        console.error "Oops!"
    .one 'hide.bs.modal', ->
      return unless xhr
      xhr.abort()
      xhr = 0
    .modal()
    progress = $ '.progress-bar', modal
    progress.css width: 0
    false
  @
