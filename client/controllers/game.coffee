Client = require "../client"

###
## private methods
###
_addUser = (user) ->
    $(".users").append("<img src='#{user.profile_image_url}' />")

###
## public API
###
GameController =
    init: ->
        console.log "game init"

        $(document).on "click", ".tile", (e) ->
            e.preventDefault()

            data =
                x: $(this).data("x")
                y: $(this).data("y")

            Client.getSocket().emit "game:tile:hit", data

        Client.getSocket().emit "game:init"

    destroy: ->
        console.log "game destroy"

        $(document).off "click", ".tile"

    prepare: (data) ->
        # set up game grid
        for x in [0..data.grid.w-1]
            for y in [0..data.grid.h-1]
                str = "<div class=tile-wrap>
                    <div class=tile data-x=#{x} data-y=#{y}>
                        <div class=front></div>
                        <div class=back></div>
                    </div>
                </div>"
                $(".grid").append str

        # add current game users
        _addUser player for player in data.players
        
        # always keep this here last to let the server know we're good to go
        Client.getSocket().emit "game:ready"

    start: ->
        console.log "GO!"

    showTile: (data) ->
        tile = $(".tile[data-x=#{data.x}][data-y=#{data.y}]")
        .css("-webkit-transition", "-webkit-transform #{data.speed}ms")
        .addClass("flipped")

    hideTile: (data) ->
        tile = $(".tile[data-x=#{data.x}][data-y=#{data.y}]")
        .removeClass "flipped"

    addUser: (data) ->
        _addUser data

module.exports = GameController
