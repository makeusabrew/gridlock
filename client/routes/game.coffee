Client         = require "../client"
GameController = require "../controllers/game"

GameRouter =
    load: (socket) ->
        socket.on "game:info", (data) ->
            GameController.prepare data

        socket.on "game:start", ->
            GameController.start()

        socket.on "game:tile:show", (data) ->
            GameController.showTile data

        socket.on "game:tile:hide", (data) ->
            GameController.hideTile data

        socket.on "game:user:join", (data) ->
            GameController.addUser data

    init: ->
        GameController.init()

    destroy: ->
        GameController.destroy()

module.exports = GameRouter
