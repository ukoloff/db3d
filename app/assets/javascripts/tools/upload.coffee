###
Отображение имени загружаемого файла
###
prefix = 'db3d.file.'

$ ->
  label = $ '#file-name'
  return unless label.length
  form = setupForm label
  $ 'input[type=file]', form
  .change ->
    form.trigger "#{prefix}clear"
    form.trigger "#{prefix}name", [@value.replace /^.*[\\\/]/, '']

  dragDrop form if window.FileReader

# Навесить обработчики на разные события в связи с загрузкой файлов
setupForm = (label)->
  dropped = 0
  form = label.parents 'form:first'
  .on "#{prefix}name", (e, name)->
    # Отобразить имя файла
    label.text name
  .on "#{prefix}clear", ->
    # Не использовать файл, брошенный на форму
    dropped = 0
  .on "#{prefix}drop", (e, file)->
    # Уронили файл
    console.log 'DROP', file
    dropped = file
    form.trigger "#{prefix}name", [file.name]
  .on "#{prefix}dropped", (e, formData)->
    # Брошенный файл нужно грузить
    return unless dropped
    name = $ 'input[type=file]', form
    formData.set name[0].name, dropped

# http://stackoverflow.com/questions/28226021/entire-page-as-a-dropzone-for-drag-and-drop
dragDrop = (form)->
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
    form.trigger 'db3d.file.drop', [e.originalEvent.dataTransfer.files[0]]
    false

  iconShow = (e)->
    icon.css
      left: e.pageX - icon.width() / 2
      top: e.pageY - icon.height() / 2
    .show()
