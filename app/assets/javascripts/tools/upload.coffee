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
  $ window
  .on 'dragenter', (e)->
    return false unless e.originalEvent.dataTransfer?.types[0] == 'Files'
    lastTarget = e.target
    zone.css 'visibility', 'visible'
    false
  .on 'dragover', ->
    false
  .on 'dragleave', (e)->
    return false if e.target != lastTarget
    zone.css 'visibility', ''
    false
