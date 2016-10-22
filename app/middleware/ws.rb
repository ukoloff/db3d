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
    if Faye::WebSocket.websocket? env
      ::WsRoute.start Faye::WebSocket.new env, nil, ping: KeepAlive
    else
      @app.call env
    end
  end
end
