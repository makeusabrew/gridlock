ChatProxy = require "../proxies/chat"

ChatController =
    io: null

    lobbyChat: (socket, data) ->
        packet =
            author: socket.user.get 'screen_name'
            message: data

        ChatProxy.chat packet

module.exports = ChatController
