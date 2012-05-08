Client = require "../client.coffee"
View   = require "../view.coffee"

LobbyController =
    init: ->
        console.log "lobby init"

        $(document).on "click", ".game-start", (e) ->
            e.preventDefault()

            Client.getSocket().emit "lobby:game:start"

        $(document).on "click", ".game", (e) ->
            e.preventDefault()
            Client.getSocket().emit "lobby:game:join", {id: $(this).attr("data-id")}

        $(document).on "submit", ".chat-form", (e) ->
            e.preventDefault()

            data = $(this).find("input[name=chat]").val()
            Client.getSocket().emit "chat:lobby", data

        # ok server, we're ready. Give us what you've got.
        Client.getSocket().emit "lobby:init"

    destroy: ->
        console.log "lobby destroy"

        $(document).off "click", ".game-start"
        $(document).off "click", ".game"
        $(document).off "click", ".chat-form"

    info: (data) ->
        console.log data
        games = data.games
        for gameId in games
            elem = $("<div data-id=#{gameId} class=game>#{gameId}</div>")
            $(".game-list").append elem

    addChat: (data) ->
        View.render "chat:line", data

module.exports = LobbyController
