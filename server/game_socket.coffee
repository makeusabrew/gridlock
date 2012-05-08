SuperSocket = (socket) ->
    @socket = socket
    @state  = null
    @user = null
    @game = null

    @changeState = (state) ->
        @state = state
        @socket.emit "state:change", state

    @on = (msg, data) ->
        @socket.on msg, data

    @emit = (msg, data) ->
        @socket.emit msg, data

    @setUser = (user) ->
        @user = user

    return

module.exports = SuperSocket
