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

class Game
    constructor: ->
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

module.exports = Game
