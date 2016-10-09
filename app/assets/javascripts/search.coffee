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
  q = form.find 'input:first'
  count = form.find 'span:first'
  pager = 0
  qv = ''
  sample = data.slice()
  render = (page = 1, pages = Math.ceil sample.length / pagesize)->
    tbody.html t shown = sample.slice (page - 1) * pagesize, page * pagesize
    nav.html pager = $.pager pages, page, render
    count.text _uniq([shown.length, sample.length, data.length]).join '/'
  setInterval ->
    return if qv == q.val()
    sample = filter qv = q.val(), data
    do render
  , 100
  do render

_uniq = (array)->
  seen = {}
  for z in array when not seen[z]
    seen[z] = 1
    z

filter = (q, array)->
  return array.slice() unless q
  match = (rec)->
    return true for k, v of rec when 0 <= String(v).indexOf q
    false
  z for z in array when match z
