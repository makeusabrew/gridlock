express = require "express"
app     = express.createServer()
io      = require("socket.io").listen(app)
mongoose= require "mongoose"

SuperSocket = require "./server/super_socket"

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

# global proxies
require("./server/proxies/chat").io = io

# wire up sockets
io.sockets.on "connection", (socket) ->
    ###
    ## client boot stuff
    ###
    superSocket = new SuperSocket socket

    superSocket.changeState "welcome"

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
    require("./server/routes/game").load io, superSocket

    ###
    ##  Chat routes - bit of a grandiose term, only one for now
    ###
    require("./server/routes/chat").load io, superSocket
