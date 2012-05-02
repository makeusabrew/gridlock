Client = require "../client.coffee"

Welcome =
    getRoutes: ->
        return {}

    init: ->
        console.log "welcome init"

        $("#login").on 'submit', (e) ->
            e.preventDefault()

            Client.getSocket().emit "welcome:login"

module.exports = Welcome
