module.exports = (data) ->
    if data.games.length
        for gameId in data.games
            elem = $("<div data-id=#{gameId} class=game>#{gameId}</div>")
            $(".game-list").append elem
    else
        $(".game-list").append "No games yet. Why not start one?"
