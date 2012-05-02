_socket    = null
_connected = false
_wrapper   = null

_states =
    welcome: require("./routes/welcome.coffee")

Client =
    connect: ->
        return false if not io?
        
        _wrapper = $("div[data-wrapper]")

        _socket = io.connect()

        _socket.on "connect", ->
            _connected = true

        _socket.on "state:change", (state) ->
            _socket.emit "state:fetch", state, (response) ->
                state = _states[state]

                _socket.on _event, _method for _event, _method of state.getRoutes()

                state.init()

                _wrapper.html response

    getSocket: ->
        _socket
            

module.exports = Client
