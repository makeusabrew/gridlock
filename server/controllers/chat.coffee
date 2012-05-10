ChatController =
    io: null

    lobbyChat: (socket, data) ->
        packet =
            message: data

        ChatProxy.chat packet

module.exports = ChatController
