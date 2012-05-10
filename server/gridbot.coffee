ChatProxy = require "./proxies/chat"
GridBot =
    chat: (text) ->
        data =
            message: text

        ChatProxy.chat data

module.exports = GridBot
