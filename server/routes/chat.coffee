ChatController = require "../controllers/chat"

module.exports =
    load: (io, socket) ->
        ChatController.io = io

        socket.on "chat:lobby", (data)->
            ChatController.lobbyChat socket, data
