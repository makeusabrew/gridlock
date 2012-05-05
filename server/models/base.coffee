class Base
    constructor: ->
        @model = {}

    get: (key) ->
        return @model[key]

    set: (key, value) ->
        @model[key] = value

    getIdentifier: ->
        return null

module.exports = Base
