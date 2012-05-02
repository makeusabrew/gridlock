PageController = require "./controllers/page"

module.exports = (app) ->
    PageController.init app

    app.get "/", (req, res) ->
        PageController.index req, res
