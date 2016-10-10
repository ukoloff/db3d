#
# Кнопки сортировки в таблице
#
$.sorter = (table)->
  click = 0
  cells = $ 'thead tr th', table
  .map (i, th)->
    $ th
    .append z = $ tDiv
    z

  render = (initial)->
    cells.each (i, th)->
      th.append b = $ t if i + 1 != Math.abs initial
        0
      else if initial > 0
        +1
      else
        -1

  render: render
  click: (cb)-> click = cb

tDiv = do withOut ->
  div class: 'pull-right dropdown'

t = withOut (state)->
  list =
    a:
      text: 'По возрастанию'
      icon: 'sort-numeric-asc'
    b:
      text: 'Без сортировки'
      icon: 'reorder'
    c:
      text: 'По убыванию'
      icon: 'sort-numeric-desc'
  button
    class: "btn btn-xs dropdown-toggle"
    title: 'Сортировка'
    data: toggle: "dropdown"
    -> i class: "fa fa-sort#{
      if state
        "-" + if state > 0 then 'desc' else 'asc'
      else
        ''
    }"
  ul class: "dropdown-menu", ->
    n = 1
    for k, v of list
      li
        class: if state == n--
          if state
            'disabled'
          else
            'hide'
        -> a
          href: '#'
          -> i class: "fa fa-fw fa-#{v.icon}"
          ' '
          v.text
