Client         = require "../client.coffee"
GameController = require "../controllers/game.coffee"

Game =
    getRoutes: ->
        return {
            "game:info": (data) ->
                GameController.prepare data

            "game:start": ->
                GameController.start()

            "game:tile:flip": (data) ->
                GameController.actuallyFlipTile data
        }

    init: ->
        console.log "game init"

        Client.getSocket().emit "game:init"

module.exports = Game
