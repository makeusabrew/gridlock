Client         = require "../client.coffee"
GameController = require "../controllers/game.coffee"

GameRouter =
    load: (socket) ->
        socket.on "game:info", (data) ->
            GameController.prepare data

        socket.on "game:start", ->
            GameController.start()

        socket.on "game:tile:flip", (data) ->
            GameController.actuallyFlipTile data

    init: ->
        GameController.init()

    destroy: ->
        GameController.destroy()

module.exports = GameRouter
