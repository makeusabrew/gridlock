GameController =
    init: (io, socket) ->
        # @todo unstub. Obviously.
        info =
            grid:
                w: 10
                h: 10
        socket.emit "game:info", info

    start: (io, socket) ->
        # @todo client is ready to rock. are we?
        socket.emit "game:start"

    flipTile: (io, socket) ->
        # @todo decide whether to flip a tile or not
        data =
            x: Math.floor(Math.random()*10)
            y: Math.floor(Math.random()*10)
            transition: 500 + Math.floor(Math.random()*501)
            duration: 500 + Math.floor(Math.random()*2501)

        io.sockets.emit "game:tile:flip", data

    loadRoutes: (io, socket) ->
        socket.on "game:init", =>
            @init io, socket

        socket.on "game:ready", =>
            @start io, socket

        socket.on "game:tile:flip", =>
            @flipTile io, socket

module.exports = GameController
