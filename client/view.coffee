viewMap =
    "chat:line": require "./views/chat-line.coffee"
View =
    render: (view, data) ->
        viewMap[view](data)

module.exports = View
