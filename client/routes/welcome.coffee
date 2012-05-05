WelcomeController = require "../controllers/welcome"

WelcomeRouter =
    load: (socket) ->
        socket.on "welcome:authed", (data) ->
            WelcomeController.authed data
        return null

    init: ->
        WelcomeController.init()

    destroy: ->
        WelcomeController.destroy()

module.exports = WelcomeRouter
