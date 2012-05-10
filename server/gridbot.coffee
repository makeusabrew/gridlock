ChatProxy = require "./proxies/chat"
GridBot =
    chat: (data) ->
        ChatProxy.chat data

module.exports = GridBot
