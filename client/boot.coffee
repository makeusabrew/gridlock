Client = require "./client"

_states =
    welcome: require("./routes/welcome.coffee")
    game:    require("./routes/game.coffee")

Client.setStates _states

Client.connect()
