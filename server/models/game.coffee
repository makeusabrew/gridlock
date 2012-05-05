mongoose = require "mongoose"
Schema   = mongoose.Schema
ObjectId = mongoose.ObjectId

GameSchema = new Schema({
    width: Number,
    height: Number,
    startDate: Date
})

GameModel = mongoose.model "GameModel", GameSchema

Tile = require "./tile"

EventEmitter = require("events").EventEmitter

class Game
    constructor: ->
        @emitter = new EventEmitter()
        @model = new GameModel()
        @tiles = []

    createGrid: (cb) ->
        for x in [0..9]
            @tiles[x] = []
            for y in [0..9]
                @tiles[x][y] = new Tile()

        @model.width  = 10
        @model.height = 10
        @model.save (err) ->
            cb err

    getTile: (x, y) ->
        return @tiles[x][y]

    start: ->
        console.log "game starting"
        @queueTileFlip()

    queueTileFlip: ->
        delay = 1000 + Math.floor(Math.random()*4001)
        setTimeout =>
            @flipTile()
        , delay

    flipTile: ->
        @emitter.emit "game:tile:flip"
        @queueTileFlip()

    on: (event, args) ->
        @emitter.on event, args

module.exports = Game