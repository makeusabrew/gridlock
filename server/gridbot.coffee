ChatProxy = require "./proxies/chat"
screen_name = "gridloccbot"
GridBot =
    chat: (text) ->
        data =
            author: screen_name
            message: text

        ChatProxy.chat data

module.exports = GridBot
