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
                $(".auth-state").replaceWith("<a class='auth-state btn btn-success' href=#>Connect with Twitter</a>")

                $(".auth-state").on "click", (e) ->
                    e.preventDefault()
                    T.signIn()

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
        $(".auth-state").remove()

    destroy: ->
        console.log "welcome destroy"
        $("#login").off "submit"


module.exports = WelcomeController
