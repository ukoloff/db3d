#
# Быстрый полнотекстовый поиск
#
pagesize = Math.max 10, +localStorage?['pagesize'] || 0
localStorage?['pagesize'] = pagesize

sorters = _.map
  name: 0
  date: (z)->
    String z.date2str || ''
    .split /\D+/
    .reverse()
    .join '-'
  author: 0
  (v, k)->
    v ||
    (z)-> (z[k] or '').toLowerCase()

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
      td z.author
      td -> _.each z._, (tag)->
        span
          class: 'label label-success'
          tag.name
        text ' '

start = (json, table)->
  data = toolsOf json
  nav = table.next()
  tbody = table.find 'tbody'
  form = table.prev()
  q = form.find 'input:first'
  q.val localStorage?['q'] or ''
  count = form.find 'span:first'
  pager = 0
  qv = 0
  sample = []
  sortMode = localStorage?['sort']
  sorted = []

  # Установить обработчики сортировки
  $.sorter table
  .render sortMode
  .click (n)->
    localStorage?['sort'] = n
  .click (n)->
    sortMode = n
    do reSort

  # Нарисовать отфильтрованное
  render = (page = 1, pages = Math.ceil sample.length / pagesize)->
    tbody.html t shown = sorted.slice (page - 1) * pagesize, page * pagesize
    nav.html pager = $.pager pages, page, render
    count.text _.uniq([shown.length, sample.length, data.length]).join '/'

  reSort = ->
    if sortMode
      sorted = _.sortBy sample, sorters[Math.abs(sortMode) - 1]
      sorted = sorted.reverse() if sortMode < 0
    else
      sorted = sample.slice()
    do render

  do reFilter = ->
    return if qv == q.val()
    sample = filter qv = q.val(), data
    localStorage?['q'] = qv
    do reSort
  setInterval reFilter, 100

filter = (q, array)->
  return array.slice() unless q
  q = q.toLowerCase()
  match = (rec)->
    for k, v of rec
      if '_' == k
        for tag in v when 0 <= tag._n.indexOf q
          return true
      else if 0 <= String(v or '').toLowerCase().indexOf q
        return true
    false
  z for z in array when match z

toolsOf = (json)->
  _.each tools = json.tools, (tool)->
    (tool._ = []).$ = 0
  idx = _.indexBy tools, 'id'
  _.each json.tags, (tag)->
    tag._n = tag.name.toLowerCase()
    $ = tag._.length
    _.each tag._, (id)->
      if tool = idx[id]
        _ = tool._
        _.push tag
        _.$ += $
  tools
