$ ->
  label = $ '#file-name'
  return unless label.length
  $ 'input[type=file]'
  .change ->
    label.text @value.replace /^.*[\\\/]/, ''
