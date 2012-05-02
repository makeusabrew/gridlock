$ ->
    Client = require "./client"

    _routers =
        welcome: require("./routes/welcome")
        game:    require("./routes/game")

    Client.loadRouters _routers

    Client.connect()
