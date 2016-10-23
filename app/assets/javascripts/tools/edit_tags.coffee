$.editTags = (tags)-> $ ->
  f = $ '.form-inline'
  t = $('input:last', f).clone().wrap('<p>').parent().html() +
    do withOut -> span ' '
  autocomplete = (x) ->
    x
    .autocomplete
      minLength: 0
      source: tags
    .focus ->
      $ @
      .autocomplete 'search', ''

  autocomplete f.find 'input'

  $ 'button', f
  .click ->
    $ @
    .before z = $ t
    autocomplete z.filter 'input'
