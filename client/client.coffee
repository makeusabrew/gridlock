_socket    = null
_connected = false
_wrapper   = null

_states = null

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

                _wrapper.html response

                state.init()

    setStates: (states) ->
        _states = states;

    getSocket: ->
        _socket
            

module.exports = Client
