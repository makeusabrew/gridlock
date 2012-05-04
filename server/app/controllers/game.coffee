GameModel = require "../models/game"

activeGames = {}

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
            
            activeGames[game.model._id] = game

            socket.set "gameId", game.model._id
            socket.emit "game:info", info

    start: (socket) ->
        # @todo client is ready to rock. are we?
        socket.emit "game:start"

    flipTile: (socket) ->
        socket.get "gameId", (err, gameId) =>
            console.log gameId
            game = activeGames[gameId]

            x = Math.floor(Math.random()*10)
            y = Math.floor(Math.random()*10)
            speed = 300 + Math.floor(Math.random()*701)
            duration = 500 + Math.floor(Math.random()*3501)

            tile = game.getTile x, y
            tile.show speed, duration, =>
                @io.sockets.emit "game:tile:hide", {x:x, y:y}

            @io.sockets.emit "game:tile:show", {x: x, y: y, speed: speed}

    checkHit: (socket, data) ->
        console.log data

module.exports = GameController
