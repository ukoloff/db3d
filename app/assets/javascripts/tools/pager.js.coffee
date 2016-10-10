$.pager = pager = (pages, page, click)->
  z = $ tPager pages, page
  z.find('a').click ->
    click? Number(@title or $(@).text()), pages
    false
  z

tPager = withOut (pages, page)->
  return if pages<2
  page = 1 if page <1
  page = pages if page>pages

  ranges = [[1,3]]
  _.each [[page-2, page+2], [pages-2, pages]], (range)->
    if (z=_.last ranges)[1]+3>range[0]
      z[1]=range[1]
    else
      ranges.push false, range

  ul class: 'pagination', ->
    li -> a
      href: '#'
      title: page - 1 or pages
      -> i class: 'fa fa-angle-double-left'

    _.each ranges, (range)->
      if range
        for n in [range[0]..range[1]]
          li
            class: (n==page) and 'active'
            -> a
              href: '#'
              n
      else
        li -> span -> i class: 'fa fa-ellipsis-h'

    li -> a
      href: '#'
      title: if page < pages then page + 1 else 1
      -> i class: 'fa fa-angle-double-right'

tPager.id = 'tools/pager'
