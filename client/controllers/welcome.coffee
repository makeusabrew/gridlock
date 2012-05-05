Client = require "../client.coffee"

WelcomeController =
    init: ->
        console.log "welcome init"

        $("#login").on "submit", (e) ->
            e.preventDefault()

            Client.getSocket().emit "welcome:login"

    destroy: ->
        $("#login").off "submit"


module.exports = WelcomeController
