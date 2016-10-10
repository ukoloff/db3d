#
# Быстрый полнотекстовый поиск
#
pagesize = Number localStorage?['pagesize']
pagesize = Math.max 10, pagesize || 0
localStorage?['pagesize'] = pagesize

$ ->
  table = $ '#q'
  return unless table.length
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
  nav = table.next()
  tbody = table.find 'tbody'
  form = table.prev()
  q = form.find 'input:first'
  q.val localStorage?['q'] or ''
  count = form.find 'span:first'
  pager = 0
  qv = 0
  sample = []

  # Установить обработчики сортировки
  $.sorter table
  .render localStorage?['sort']
  .click (n)->
    localStorage?['sort'] = n
  .click (n)->
    console.log "Sort:", n

  # Нарисовать отфильтрованное
  render = (page = 1, pages = Math.ceil sample.length / pagesize)->
    tbody.html t shown = sample.slice (page - 1) * pagesize, page * pagesize
    nav.html pager = $.pager pages, page, render
    count.text _.uniq([shown.length, sample.length, data.length]).join '/'

  do refilter = ->
    return if qv == q.val()
    sample = filter qv = q.val(), data
    localStorage?['q'] = qv
    do render
  setInterval refilter, 100

filter = (q, array)->
  return array.slice() unless q
  q = q.toLowerCase()
  match = (rec)->
    return true for k, v of rec when 0 <= String(v).toLowerCase().indexOf q
    false
  z for z in array when match z
