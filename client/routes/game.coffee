Client = require "../client.coffee"

Game =
    getRoutes: ->
        return {
            "game:info": (data) ->
                console.log data
        }

    init: ->
        console.log "game init"

        Client.getSocket().emit "game:init"

module.exports = Game
