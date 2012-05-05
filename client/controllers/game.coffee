Client = require "../client"
SoundManager = require "../sound_manager"

###
## private bits
###
_addUser = (user) ->
    $(".users").append("<div data-user-id='#{user.twitter_id}'><img src='#{user.profile_image_url}' /> <span>0</span></div>")

cursor =
    x: 0
    y: 0

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

        # wire up handler to keep track of cursor position
        $(document).on "mousemove", (e) ->
            cursor.x = e.pageX
            cursor.y = e.pageY

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
        setInterval ->
            Client.getSocket().emit "game:user:position" cursor
        , 500

    showTile: (data) ->
        tile = $(".tile[data-x=#{data.x}][data-y=#{data.y}]")

        tile
        .css("-webkit-transition", "-webkit-transform #{data.speed}ms")
        .css("-moz-transition", "-moz-transform #{data.speed}ms")
        .css("-ms-transition", "-ms-transform #{data.speed}ms")
        .css("-o-transition", "-o-transform #{data.speed}ms")
        .css("transition", "transform #{data.speed}ms")
        .addClass "flipped"

        face = tile.find(".back")
        .addClass(data.type.type)
        .addClass(data.type.id)

        switch data.type.type
            when "points"
                face.html(data.type.value)

        SoundManager.playSound "tile_flip"

    hideTile: (data) ->
        tile = $(".tile[data-x=#{data.x}][data-y=#{data.y}]")

        tile.removeClass "flipped"

        # we need to make sure we remove whatever class the tile
        # temporarily had only *after* the transition completes
        setTimeout ->
            tile.find(".back")
            .attr("class", "back")
            .empty()
        , data.speed

    addUser: (data) ->
        _addUser data

    userScore: (data) ->
        # @todo don't like this... but it'll do for a rough prototype
        span = $("[data-user-id='#{data.id}'] span")
        score = parseInt span.html()
        span.html(parseInt(data.score) + score)

module.exports = GameController
