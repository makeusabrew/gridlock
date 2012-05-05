$ ->
    Client = require "./client"

    _routers =
        game:    require "./routes/game"
        lobby:   require "./routes/lobby"
        welcome: require "./routes/welcome"

    Client.loadRouters _routers

    Client.connect()
