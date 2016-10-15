$.editTags = (tags)-> $ ->
  f = $ '.form-inline'
  t = ' ' + $('input:last', f).clone().wrap('<p>').parent().html()
  $ 'button', f
  .click ->
    $ @
    .before t
