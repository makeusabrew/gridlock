ChatProxy =
    io: null

    chat: (data) ->
        # the proxy expects an object, but doesn't expect it to have a timestamp yet
        data.timestamp = new Date()
        @io.sockets.emit "chat:lobby", data

module.exports = ChatProxy
