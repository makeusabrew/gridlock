ChatProxy =
    io: null

    chat: (data) ->
        @io.sockets.emit "chat:lobby", data

module.exports = ChatProxy
