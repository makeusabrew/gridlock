Client         = require "../client"
GameController = require "../controllers/game"

GameRouter =
    load: (socket) ->
        GameController.socket = socket

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

        socket.on "game:user:score", (data) ->
            GameController.userScore data

        socket.on "game:user:position", (data) ->
            GameController.updateUserPosition data

    init: ->
        GameController.init()

    destroy: ->
        GameController.destroy()

module.exports = GameRouter
