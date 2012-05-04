StateManager = require "../state_manager"

GameModel = require "../models/game"

LobbyController =
    io: null

    init: (socket) ->
        games = []
        games.push(id) for id,game of StateManager.getGames()

        data =
            games: games

        socket.emit "lobby:info", data

    startGame: (socket) ->
        game = new GameModel()
        game.createGrid (err) ->

            gameId = game.model._id
            StateManager.setGame gameId, game

            socket.set "gameId", gameId
            socket.emit "state:change", "game"

    joinGame: (socket, data) ->
        game = StateManager.getGame(data.id)
        if game
            socket.set "gameId", data.id
            socket.emit "state:change", "game"

module.exports = LobbyController
