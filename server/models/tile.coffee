types = require "../tile_types"

class Tile
    constructor: (x, y) ->
        @x = x
        @y = y
        @speed = null
        @duration = null
        @visible = false
        @hideHandler = null

        @type = types[Math.floor(Math.random()*types.length)]

    isVisible: ->
        return @visible

    show: (speed, duration, cb) ->
        @speed = speed
        @duration = duration

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

    getData: ->
        return {type: @type, x: @x, y: @y, speed: @speed, duration: @duration}

module.exports = Tile
