GameModel = require "../models/game"

getGame = require("../state_manager").getGame
setGame = require("../state_manager").setGame

GameController =
    io: null

    init: (socket) ->
        game = socket.game

        info =
            players: game.getUsers()
            grid:
                w: game.model.width
                h: game.model.height
        
        socket.emit "game:info", info

        # no supersocket proxy for .join
        socket.socket.join "game:#{game.getIdentifier()}"

    clientReady: (socket) ->
        game = socket.game

        gameSockets = @io.sockets.clients "game:#{game.getIdentifier()}"
        
        if gameSockets.length is 2

            game.start()
            game.on "game:tile:flip", =>
               @flipTile game.getIdentifier()

            @io.sockets.in("game:#{game.getIdentifier()}").emit "game:start"

    flipTile: (gameId) ->
        game = getGame gameId
        x = Math.floor(Math.random()*10)
        y = Math.floor(Math.random()*10)
        speed = 300 + Math.floor(Math.random()*701)
        duration = 500 + Math.floor(Math.random()*3501)

        tile = game.getTile x, y
        tile.show speed, duration, =>
            @io.sockets.in("game:#{gameId}").emit "game:tile:hide", tile.getData()

        @io.sockets.in("game:#{gameId}").emit "game:tile:show", tile.getData()

    checkHit: (socket, data) ->
        game = socket.game
        tile = game.getTile data.x, data.y

        if tile.isVisible()
            tile.hide()
            user = socket.user
            @io.sockets.in("game:#{game.getIdentifier()}").emit "game:tile:hide", tile.getData()
            if tile.type.type is "points"
                game.addUserScore user, tile.type.value

                data =
                    id: user.getIdentifier()
                    score: tile.type.value
                @io.sockets.in("game:#{game.getIdentifier()}").emit "game:user:score", data

    updatePlayerPosition: (socket, data) ->
        game = socket.game
        user = socket.user
        # finally, got game and user
        game.updateUserPosition user, data

        packet =
            x: data.x
            y: data.y
            id: user.getIdentifier()

        # we can't use the SuperSocket's proxy of .emit here. Boo
        @socket.socket.broadcast.to("game:#{game.getIdentifier()}").emit "game:user:position", packet

module.exports = GameController
