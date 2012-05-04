Client = require "../client.coffee"

LobbyController =
    init: ->
        console.log "lobby init"

        $(document).on "click", ".game-start", (e) ->
            e.preventDefault()

            Client.getSocket().emit "lobby:game:start"

        $(document).on "click", ".game", (e) ->
            e.preventDefault()

            Client.getSocket().emit "lobby:game:join", {id: $(this).attr("data-id")}

        Client.getSocket().emit "lobby:init"

    destroy: ->
        console.log "lobby destroy"

    info: (data) ->
        console.log data
        games = data.games
        for gameId in games
            elem = $("<div data-id=#{gameId} class=game>#{gameId}</div>")
            $(".game-list").append elem

module.exports = LobbyController
