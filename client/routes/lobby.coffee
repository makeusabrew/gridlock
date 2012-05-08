Client         = require "../client"
LobbyController = require "../controllers/lobby"

LobbyRouter =
    load: (socket) ->
        socket.on "lobby:info", (data) ->
            LobbyController.info data

        # chat messages currently break all the rules in that different
        # controllers handle their messages depending on state
        socket.on "chat:lobby", (data) ->
            LobbyController.addChat data

    init: ->
        LobbyController.init()

    destroy: ->
        LobbyController.destroy()

module.exports = LobbyRouter
