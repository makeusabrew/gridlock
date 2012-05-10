StateManager = require "../state_manager"
GameModel    = require "../models/game"
GridBot      = require "../gridbot"

LobbyController =
    io: null

    init: (socket) ->
        games = []
        games.push(id) for id,game of StateManager.getGames()

        data =
            games: games

        socket.emit "lobby:info", data

        GridBot.chat "#{socket.user.get 'screen_name'} joined the lobby!"

    startGame: (socket) ->
        game = new GameModel()
        game.createGrid (err) ->

            user = socket.user
            game.addUser user

            gameId = game.model._id
            StateManager.setGame gameId, game

            socket.game = game
            socket.changeState "game"

    joinGame: (socket, data) ->
        game = StateManager.getGame(data.id)
        if game
            user = socket.user
            game.addUser user

            @io.sockets.in("game:#{data.id}").emit "game:user:join", user.model

            socket.game = game
            socket.changeState "game"

module.exports = LobbyController
