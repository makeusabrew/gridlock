Client         = require "../client"
LobbyController = require "../controllers/lobby"

LobbyRouter =
    load: (socket) ->
        socket.on "lobby:info", (data) ->
            LobbyController.info data

    init: ->
        LobbyController.init()

    destroy: ->
        LobbyController.destroy()

module.exports = LobbyRouter
