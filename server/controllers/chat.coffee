ChatController =
    io: null

    lobbyChat: (socket, data) ->
        packet =
            message: data

        @io.sockets.emit "chat:lobby", packet

module.exports = ChatController
