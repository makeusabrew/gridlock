LobbyController = require "../controllers/lobby"

LobbyRouter =
    load: (io, socket) ->
        LobbyController.io = io

        socket.on "lobby:init", ->
            LobbyController.init socket

        socket.on "lobby:game:start", ->
            LobbyController.startGame socket

        socket.on "lobby:game:join", (data) ->
            LobbyController.joinGame socket, data

module.exports = LobbyRouter
