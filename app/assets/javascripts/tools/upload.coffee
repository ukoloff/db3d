$ ->
  label = $ '#file-name'
  return unless label.length
  $ 'input[type=file]'
  .change ->
    label.text @value.replace /^.*[\\\/]/, ''

  do dragDrop if window.FileReader

# http://stackoverflow.com/questions/28226021/entire-page-as-a-dropzone-for-drag-and-drop
dragDrop = ->
  zone = $ '.dropzone'
  lastTarget = 0

  show = (show)->
    zone.css 'visibility', if show then 'visible' else ''
    false

  $ window
  .on 'dragenter', (e)->
    lastTarget = e.target
    show true
  .on 'dragover', ->
    false
  .on 'dragleave', (e)->
    return false if e.target != lastTarget
    show false
  .on 'drop', (e)->
    $('input[type=file]')[0].files = e.originalEvent.dataTransfer.files
    show false
