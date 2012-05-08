Client = require "../client"
SoundManager = require "../sound_manager"

###
## private bits
###
users = {}

_addUser = (user) ->
    # this could be interesting; attaching actual dom elements to objects? feels a
    # bit non MVC (assuming user is our M) but could work...
    user.cursor = $("<img data-user-cursor='#{user.twitter_id}' class=user-cursor src='#{user.profile_image_url}' />")

    $(".users").append("<div data-user-id='#{user.twitter_id}'><img src='#{user.profile_image_url}' /> <span>0</span></div>")

    $("body").append(user.cursor)

    users[user.twitter_id] = user

oldCursor =
    x: 0
    y: 0

cursor =
    x: 0
    y: 0

###
## public API
###
GameController =
    socket: null

    init: ->
        console.log "game init"

        $(document).on "click", ".tile", (e) ->
            e.preventDefault()

            data =
                x: $(this).data("x")
                y: $(this).data("y")

            # we can't use fat arrow notation here, since it'll break the scope of
            # the element which was clicked ('this', above) which we need
            GameController.socket.emit "game:tile:hit", data

        # wire up handler to keep track of cursor position
        $(document).on "mousemove", (e) ->
            gridOffset = $(".grid").offset()
            cursor.x = e.pageX - gridOffset.left
            cursor.y = e.pageY - gridOffset.top

        @socket.emit "game:init"

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
        @socket.emit "game:ready"

    start: ->
        console.log "GO!"
        ###
        really don't like cursor stuff at the moment, so disabling for now
        setInterval =>
            if cursor.x != oldCursor.x or cursor.y != oldCursor.y
                @socket.emit "game:user:position", cursor
                oldCursor.x = cursor.x
                oldCursor.y = cursor.y
        , 100
        ###

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

    updateUserPosition: (data) ->
        user = users[data.id]

        gridOffset = $(".grid").offset()
        widthOffset = user.cursor.width() / 2
        heightOffset = user.cursor.height() / 2
        user.cursor.css({
            "left": data.x + gridOffset.left - widthOffset,
            "top": data.y + gridOffset.top - heightOffset
        })
        

module.exports = GameController
