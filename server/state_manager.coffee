activeGames = {}

StateManager =
    getGame: (gameId) ->
        return activeGames[gameId] if activeGames[gameId]?
    
    setGame: (gameId, game) ->
        activeGames[gameId] = game

    getGames: ->
        return activeGames

module.exports = StateManager
