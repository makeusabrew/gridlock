Client = require "../client.coffee"
View   = require "../view.coffee"

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
                $(".auth-state").replaceWith("<a class='auth-state btn btn-primary' href=#>Connect with Twitter</a>")

                $(".auth-state").on "click", (e) ->
                    e.preventDefault()
                    T.signIn()

            T.bind "authComplete", (e, user) ->
                authUser user

            T.bind "signOut", (e) ->
                console.log e

        # proceed to lobby binding
        $(document).on "click", ".enter-lobby", (e) ->
            e.preventDefault()
            Client.getSocket().emit "welcome:proceed"

    authed: (data) ->
        Client.setUser data
        $("[data-user]").html("<a class='nav-username' href=http://twitter.com/#{data.screen_name}>@#{data.screen_name}</a>")
        $("[data-avatar]").html("<img src='#{data.profile_image_url}' class='nav-avatar ' />")

        View.render "welcome:authed", data

    destroy: ->
        console.log "welcome destroy"
        $("#login").off "submit"


module.exports = WelcomeController
