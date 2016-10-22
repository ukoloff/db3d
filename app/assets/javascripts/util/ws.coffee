$.ws = (path = '')->
  a = $ "<a href='/#{path}'>"
  s = new WebSocket a[0].href.replace /^http/, 'ws'
  s.onmessage = (e)->
    console.log "WebSocket got:", e.data
  s
