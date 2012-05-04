GameModel = require "../models/game"

getGame = require("../state_manager").getGame
setGame = require("../state_manager").setGame

GameController =
    io: null

    init: (socket) ->
        socket.get "gameId", (err, gameId) =>
            game = getGame gameId

            info =
                grid:
                    w: game.model.width
                    h: game.model.height
            
            socket.emit "game:info", info
            socket.join "game:#{gameId}"

    start: (socket) ->
        socket.get "gameId", (err, gameId) =>
            game = getGame gameId

            gameSockets = @io.sockets.clients "game:#{gameId}"
            
            if gameSockets.length is 2

                game.start()
                game.on "game:tile:flip", =>
                   @flipTile gameId

                @io.sockets.in("game:#{gameId}").emit "game:start"

    flipTile: (gameId) ->
        game = getGame gameId
        x = Math.floor(Math.random()*10)
        y = Math.floor(Math.random()*10)
        speed = 300 + Math.floor(Math.random()*701)
        duration = 500 + Math.floor(Math.random()*3501)

        tile = game.getTile x, y
        tile.show speed, duration, =>
            @io.sockets.in("game:#{gameId}").emit "game:tile:hide", {x:x, y:y}

        @io.sockets.in("game:#{gameId}").emit "game:tile:show", {x: x, y: y, speed: speed}

    checkHit: (socket, data) ->
        console.log data

module.exports = GameController
