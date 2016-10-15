$.editTags = (tags)-> $ ->
  f = $ '.form-inline'
  t = ' ' + $('input:last', f).clone().wrap('<p>').parent().html()

  autocomplete = (x) ->
    x.find 'input'
    .autocomplete
      minLength: 0
      source: tags
    .focus ->
      $ @
      .autocomplete 'search', ''

  autocomplete f

  $ 'button', f
  .click ->
    $ @
    .before autocomplete $ t
