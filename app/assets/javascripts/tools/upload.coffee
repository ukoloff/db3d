###
Отображение имени загружаемого файла
###
$ ->
  label = $ '#file-name'
  return unless label.length
  $ 'input[type=file]'
  .change ->
    label.text @value.replace /^.*[\\\/]/, ''

  do dragDrop if window.FileReader

# http://stackoverflow.com/questions/28226021/entire-page-as-a-dropzone-for-drag-and-drop
dragDrop = ->
  lastTarget = 0
  $ window
  .on 'dragenter', (e)->
    lastTarget = e.target
    false
  .on 'dragover', (e)->
    console.log 'DRAG', e
    false
  .on 'dragleave', (e)->
    return false if e.target != lastTarget
    false
  .on 'drop', (e)->
    console.log 'DROP', e
    false
