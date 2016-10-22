#
# WebSocket middleware
#
# See https://devcenter.heroku.com/articles/ruby-websockets
#
class Ws
  KeepAlive = 15

  def initialize app
    @app = app
  end

  def call env
    return @app.call env unless Faye::WebSocket.websocket? env

    ws = Faye::WebSocket.new env, nil, ping: KeepAlive

    ws.on :open do |event|
      ws.send "Hello!"
    end

    ws.on :message do |event|
      ws.send event.data
    end

    ws.rack_response
  end
end
