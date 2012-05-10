# we can't dynamically require with browserify, so we have to take
# the hit here and map physical files to arbitrary strings instead
viewMap =
    "chat:line": require "./views/chat-line.coffee"
    "lobby:games": require "./views/lobby-games.coffee"

View =
    render: (view, data) ->
        viewMap[view](data)

module.exports = View
