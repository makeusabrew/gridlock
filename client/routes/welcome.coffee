WelcomeController = require "../controllers/welcome"

WelcomeRouter =
    load: (socket) ->
        return null

    init: ->
        WelcomeController.init()

    destroy: ->
        WelcomeController.destroy()

module.exports = WelcomeRouter
