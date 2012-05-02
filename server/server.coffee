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
require("./app/routes/url").load app

# wire up sockets
io.sockets.on "connection", (socket) ->
    ###
    ## client boot stuff
    ###
    gameSocket = new GameSocket socket

    gameSocket.changeState "welcome"

    ###
    ## one off static controller 
    ###
    StaticController = require "./app/controllers/static"

    socket.on "state:fetch", (state, cb) ->
        if gameSocket.state is state
            StaticController.fetchState state, (data) ->
                cb data

    ###
    ##  Welcome logic
    ###
    socket.on "welcome:login", ->
        gameSocket.changeState "game"


    ###
    ##  Game routes
    ###
    require("./app/routes/game").load io, socket
