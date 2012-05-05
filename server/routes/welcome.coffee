WelcomeController = require "../controllers/welcome"
WelcomeRouter =
    load: (io, socket) ->
        WelcomeController.io = io

        socket.on "welcome:auth", (data) ->
            WelcomeController.authUser socket, data

        socket.on "welcome:proceed", ->
            WelcomeController.proceedToLobby socket

module.exports = WelcomeRouter
