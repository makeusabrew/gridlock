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
    gameSocket = new GameSocket socket

    #gameSocket.changeState "welcome"
    socket.emit "state:change", "welcome"

    ###
    ## one off static controller 
    ###
    StaticController = require "./server/controllers/static"

    socket.on "state:fetch", (state, cb) ->
        #if gameSocket.state is state
        StaticController.fetchState state, (data) ->
            cb data

    ###
    ##  Welcome logic
    ###
    socket.on "welcome:login", ->
        socket.emit "state:change", "lobby"

    ###
    ##  Lobby routes
    ###
    require("./server/routes/lobby").load io, socket

    ###
    ##  Game routes
    ###
    require("./server/routes/game").load io, socket
