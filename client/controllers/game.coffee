Client = require "../client.coffee"

GameController =
    prepare: (data) ->
        for x in [0..data.grid.w-1]
            for y in [0..data.grid.h-1]
                $(".grid").append "<div class=tile data-x=#{x} data-y=#{y}></div>"
        
        Client.getSocket().emit "game:ready"

    start: ->
        console.log "GO!"

module.exports = GameController
