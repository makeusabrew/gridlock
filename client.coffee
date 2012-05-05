$ ->
    _routers =
        game:    require "./client/routes/game"
        lobby:   require "./client/routes/lobby"
        welcome: require "./client/routes/welcome"

    Client       = require "./client/client"
    SoundManager = require "./client/sound_manager"

    SoundManager.loadSound "/sounds/tile_flip.wav", "tile_flip"

    Client.loadRouters _routers

    Client.connect()
