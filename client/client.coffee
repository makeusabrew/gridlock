_socket    = null
_connected = false
_wrapper   = null

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
                router = _routers[state]

                router.load _socket

                _wrapper.html response

                router.init()

    loadRouters: (routers) ->
        _routers = routers

    getSocket: ->
        _socket
            

module.exports = Client
