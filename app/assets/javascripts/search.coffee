#
# Быстрый полнотекстовый поиск
#
$ ->
  return unless table = $ '#q'
  $.ajax '?js'
  .complete ->
    table.find 'tfoot'
    .empty()
  .success (data)->
    start data, table

t = withOut ->
  for z in @
    tr ->
      td ->
        a
          href: "/tools/#{z.id}"
          z.name
      td z.date2str

start = (data, table)->
  pagesize = 10
  nav = table.next()
  tbody = table.find 'tbody'
  form = table.prev()
  count = form.find 'span:first'
  pager = 0
  do render = (page = 1, pages = Math.ceil data.length / pagesize)->
    tbody.html t shown = data.slice (page - 1) * pagesize, page * pagesize
    nav.html pager = $.pager pages, page, render
    count.text _uniq([shown.length, data.length]).join '/'

_uniq = (array)->
  seen = {}
  for z in array when not seen[z]
    seen[z] = 1
    z
