$.ws = (path = '')->
  a = $ "<a href='/#{path}'>"
  new WebSocket a[0].href.replace /^http/, 'ws'
