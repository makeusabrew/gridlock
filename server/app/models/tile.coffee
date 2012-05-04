class Tile
    constructor: ->
        @type = null
        @visible = false

    isVisible: ->
        return @visible

    show: (speed, duration, cb) ->
        setTimeout ->
            @visible = true
            # class the tile as visible half way through its transition
        , Math.floor(duration/2)

        setTimeout ->
            @visible = false
            cb()
        , (duration+speed)


module.exports = Tile
