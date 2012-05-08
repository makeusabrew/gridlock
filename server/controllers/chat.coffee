ChatController =
    io: null

    lobbyChat: (socket, data) ->
        # @todo more than proxy, obviously
        packet =
            message: data

        @io.sockets.emit "chat:lobby", packet

module.exports = ChatController
