_socket    = null
_connected = false
_wrapper   = null
_state     = null
_user      = null

_routers = null

Client =
    connect: ->
        return false if not io?
        
        _wrapper = $("div[data-wrapper]")

        _socket = io.connect()

        _socket.on "connect", ->
            _connected = true

        _socket.on "state:change", (state) ->
            _socket.emit "state:fetch", state, (response) ->
                _routers[_state].destroy() if _state?

                router = _routers[state]

                router.load _socket

                _wrapper.html response

                router.init()
                _state = state

    loadRouters: (routers) ->
        _routers = routers

    getSocket: ->
        _socket
            
    setUser: (user) ->
        _user = user

    getUser: ->
        _user

module.exports = Client
