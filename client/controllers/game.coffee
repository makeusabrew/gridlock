Client = require "../client.coffee"

GameController =
    init: ->
        console.log "game init"
        Client.getSocket().emit "game:init"

    prepare: (data) ->
        for x in [0..data.grid.w-1]
            for y in [0..data.grid.h-1]
                str = "<div class=tile-wrap>
                    <div class=tile data-x=#{x} data-y=#{y}>
                        <div class=front></div>
                        <div class=back></div>
                    </div>
                </div>"
                $(".grid").append str
        
        Client.getSocket().emit "game:ready"

    start: ->
        console.log "GO!"

        @queueTileFlip()

    queueTileFlip: ->
        delay = 1000 + Math.floor(Math.random()*4001)
        setTimeout =>
            @flipTile()
        , delay

    flipTile: ->
        Client.getSocket().emit "game:tile:flip"
        @queueTileFlip()

    actuallyFlipTile: (data) ->
        tile = $(".tile[data-x=#{data.x}][data-y=#{data.y}]")
        .addClass("flipped")
        .css("-webkit-transition", "-webkit-transform #{data.transition}ms")
        setTimeout ->
            tile.removeClass "flipped"

        # we have to ensure the timeout takes into account transition time AND duration
        , (data.transition+data.duration)


module.exports = GameController
