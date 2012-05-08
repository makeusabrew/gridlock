express = require "express"
app     = express.createServer()
io      = require("socket.io").listen(app)
mongoose= require "mongoose"

GameSocket = require "./server/game_socket"

mongoose.connect "localhost", "gridlock"

app.listen "8765"

# config
app.configure ->
    app.use express.static("#{__dirname}/public")
    app.set "view engine", "jade"

    app.set "view options", {layout: false}
    app.set "views", "./server/views"

    bundle = require("browserify")({mount:"/boot.js", entry:"./client.coffee"})
    app.use bundle

io.configure ->
    io.set "transports", ["websocket"]

# load routes
require("./server/routes/url").load app

# wire up sockets
io.sockets.on "connection", (socket) ->
    ###
    ## client boot stuff
    ###
    superSocket = new GameSocket socket

    superSocket.changeState "welcome"
    #socket.emit "state:change", "welcome"

    ###
    ## one off static controller 
    ###
    StaticController = require "./server/controllers/static"

    socket.on "state:fetch", (state, cb) ->
        if superSocket.state is state
            StaticController.fetchState state, (data) ->
                cb data

    ###
    ##  Welcome routes
    ###
    require("./server/routes/welcome").load io, superSocket

    ###
    ##  Lobby routes
    ###
    require("./server/routes/lobby").load io, superSocket

    ###
    ##  Game routes
    ###
    require("./server/routes/game").load io, socket
