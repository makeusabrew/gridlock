GameController = require "../controllers/game"

GameRouter =
    load: (io, socket) ->
        GameController.io = io

        socket.on "game:init", ->
            GameController.init socket

        socket.on "game:ready", ->
            GameController.start socket

        socket.on "game:tile:flip", ->
            GameController.flipTile socket

        socket.on "game:tile:hit", (data) ->
            GameController.checkHit socket, data

module.exports = GameRouter
