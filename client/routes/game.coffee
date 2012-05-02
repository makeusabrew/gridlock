Client         = require "../client.coffee"
GameController = require "../controllers/game.coffee"

Game =
    getRoutes: ->
        return {
            "game:info": (data) ->
                GameController.prepare data
        }

    init: ->
        console.log "game init"

        Client.getSocket().emit "game:init"

module.exports = Game
