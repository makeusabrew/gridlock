GameController = require "../controllers/game"

GameRouter =
    load: (io, socket) ->
        GameController.io = io

        socket.on "game:init", ->
            GameController.init socket

        socket.on "game:ready", ->
            GameController.clientReady socket

        socket.on "game:tile:hit", (data) ->
            GameController.checkHit socket, data

        socket.on "game:user:position", (data) ->
            GameController.updatePlayerPosition socket, data

module.exports = GameRouter
