$ ->
    Client = require "./client/client"

    _routers =
        game:    require "./client/routes/game"
        lobby:   require "./client/routes/lobby"
        welcome: require "./client/routes/welcome"

    Client.loadRouters _routers

    Client.connect()
