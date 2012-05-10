ChatController = require "../controllers/chat"

ChatProxy =
    chat: (data) ->
        ChatController.lobbyChat null, data

module.exports = ChatProxy
