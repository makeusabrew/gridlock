GameModel = require "../models/game"

GameController =
    io: null

    init: (socket) ->
        # @todo unstub. Obviously.
        game = new GameModel()
        game.createGrid (err) ->
            info =
                grid:
                    w: game.model.width
                    h: game.model.height
            socket.emit "game:info", info

    start: (socket) ->
        # @todo client is ready to rock. are we?
        socket.emit "game:start"

    flipTile: (socket) ->
        # @todo decide whether to flip a tile or not
        data =
            x: Math.floor(Math.random()*10)
            y: Math.floor(Math.random()*10)
            transition: 250 + Math.floor(Math.random()*751)
            duration: 500 + Math.floor(Math.random()*3501)

        @io.sockets.emit "game:tile:flip", data

    checkHit: (socket, data) ->
        console.log data

module.exports = GameController
