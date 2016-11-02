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
  $ 'body'
  .append icon = $ do withOut -> i class: 'fa fa-download fa-2x text-success'
  icon.css position: 'absolute'
  .hide()
  $ window
  .on 'dragenter', (e)->
    lastTarget = e.target
    iconShow e
    false
  .on 'dragover', (e)->
    iconShow e
    false
  .on 'dragleave', (e)->
    return false if e.target != lastTarget
    icon.hide()
    false
  .on 'drop', (e)->
    icon.hide()
    console.log 'DROP', e.originalEvent.dataTransfer.files[0]
    false

  iconShow = (e)->
    icon.css
      left: e.pageX - icon.width() / 2
      top: e.pageY - icon.height() / 2
    .show()
