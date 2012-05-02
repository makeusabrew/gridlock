express = require "express"
app     = express.createServer()
io      = require("socket.io").listen(app)

GameSocket = require "./app/game_socket"

app.listen "8765"

# config
app.configure ->
    app.use express.static("#{__dirname}/../public")
    app.set "view engine", "jade"

    app.set "view options", {layout: false}
    app.set "views", "#{__dirname}/views"

    bundle = require("browserify")({mount:"/boot.js", entry:"#{__dirname}/../client/boot.coffee"})
    app.use bundle

io.configure ->
    io.set "transports", ["websocket"]

# load routes
require("./app/routes")(app)

# wire up sockets
io.sockets.on "connection", (socket) ->
    gameSocket = new GameSocket socket

    gameSocket.changeState "welcome"

    socket.on "state:fetch", (state, cb) ->
        if gameSocket.state is state
            StaticController = require "./app/controllers/static"
            StaticController.fetchState state, (data) ->
                cb data
