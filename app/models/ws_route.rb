class WsRoute
  def initialize ws
    @ws = ws

    ws.on :open do |event|
      ws.send "Hello!"
    end

    ws.on :message do |event|
      ws.send event.data
    end
  end

  def self.start ws
    new ws
    ws.rack_response
  end
end
