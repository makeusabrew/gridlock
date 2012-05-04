class Tile
    constructor: ->
        @type = null
        @visible = false
        @hideHandler = null

    isVisible: ->
        return @visible

    show: (speed, duration, cb) ->
        @hideHandler = setTimeout =>
            @visible = true

            @hideHandler = setTimeout =>
                @visible = false
                cb()
            , duration
                
        , speed

    hide: ->
        clearTimeout @hideHandler
        @visible = false

module.exports = Tile
