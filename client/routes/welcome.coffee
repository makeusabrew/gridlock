Client = require "../client.coffee"

WelcomeRouter =
    load: (socket) ->
        return null

    init: ->
        console.log "welcome init"

        $("#login").on 'submit', (e) ->
            e.preventDefault()

            Client.getSocket().emit "welcome:login"

module.exports = WelcomeRouter
