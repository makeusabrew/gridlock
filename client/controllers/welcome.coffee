Client = require "../client.coffee"

WelcomeController =
    init: ->
        console.log "welcome init"

        # twitter auth stuff
        twttr.anywhere (T) ->
            if T.isConnected()
                userData = T.currentUser.attributes
                delete userData.status
                Client.getSocket().emit "welcome:auth", userData
            else
                T("#auth").connectButton()

            T.bind "authComplete", (e, user) ->
                userData = T.currentUser.attributes
                delete userData.status
                Client.getSocket().emit "welcome:auth", userData

            T.bind "signOut", (e) ->
                console.log e

        # proceed to lobby binding
        $("#proceed").on "click", (e) ->
            e.preventDefault()
            Client.getSocket().emit "welcome:proceed"

    authed: (data) ->
        $("#proceed").show()

    destroy: ->
        console.log "welcome destroy"
        $("#login").off "submit"


module.exports = WelcomeController
