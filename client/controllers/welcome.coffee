Client = require "../client.coffee"

###
## private api
###
authUser = (data) ->
    delete data.status
    Client.getSocket().emit "welcome:auth", data

###
## public api
###
WelcomeController =
    init: ->
        console.log "welcome init"

        # twitter auth stuff
        twttr.anywhere (T) ->
            if T.isConnected()
                authUser T.currentUser.attributes
            else
                T("#auth").connectButton()

            T.bind "authComplete", (e, user) ->
                authUser user

            T.bind "signOut", (e) ->
                console.log e

        # proceed to lobby binding
        $("#proceed").on "click", (e) ->
            e.preventDefault()
            Client.getSocket().emit "welcome:proceed"

    authed: (data) ->
        img = $("<img src='#{data.profile_image_url}' class='avatar avatar-small' />")
        $("[data-user]")
        .html("Signed in as <a href=http://twitter.com/#{data.screen_name}>@#{data.screen_name}</a>")
        .append(img)

        $("#proceed").show()

    destroy: ->
        console.log "welcome destroy"
        $("#login").off "submit"


module.exports = WelcomeController
