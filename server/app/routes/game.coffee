GameController = require "../controllers/game"

GameRouter =
    load: (io, socket) ->
        socket.on "game:init", ->
            GameController.init io, socket

        socket.on "game:ready", ->
            GameController.start io, socket

        socket.on "game:tile:flip", ->
            GameController.flipTile io, socket

module.exports = GameRouter
