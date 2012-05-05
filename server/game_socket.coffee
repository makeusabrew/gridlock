GameSocket = (socket) ->
    @socket = socket
    @state  = null

    @changeState = (state) ->
        @state = state
        @socket.emit "state:change", state

    return

module.exports = GameSocket
