#
# Быстрый полнотекстовый поиск
#
#= require without
$ ->
  return unless table = $ '#q'
  $.ajax '?js'
  .complete ->
    table.find 'tfoot'
    .empty()
  .success (data)->
    table.find 'tbody'
    .html t data

t = withOut ->
  for z in @
    tr ->
      td ->
        a
          href: "/tools/#{z.id}"
          z.name
      td z.date2str
