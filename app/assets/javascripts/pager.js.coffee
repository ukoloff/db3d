$.pager = pager = (pages, page, click)->
  z = $ tPager pages, page
  z.find('a').click ->
    click? Number(@title or $(@).text()), pages
    false
  z

tPager = withOut (pages, page)->
  # Самописный кусочек из underscore
  _each = (array, cb)-> cb z for z in array
  _last = (array)-> array[array.length - 1]

  return if pages<2
  page = 1 if page <1
  page = pages if page>pages

  ranges = [[1,3]]
  _each [[page-2, page+2], [pages-2, pages]], (range)->
    if (z=_last ranges)[1]+3>range[0]
      z[1]=range[1]
    else
      ranges.push false, range

  div class: 'pagination', -> ul ->
    li -> a
      href: '#'
      title: page - 1 or pages
      -> i class: 'icon-double-angle-left'

    _each ranges, (range)->
      if range
        for n in [range[0]..range[1]]
          li
            class: (n==page) and 'active'
            -> a
              href: '#'
              n
      else
        li -> span -> i class: 'icon-ellipsis-horizontal'

    li -> a
      href: '#'
      title: if page < pages then page + 1 else 1
      -> i class: 'icon-double-angle-right'

tPager.id = 'tools/pager'
