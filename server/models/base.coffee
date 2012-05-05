class Base
    constructor: ->
        @model = {}

    get: (key) ->
        return @model[key]

    set: (key, value) ->
        @model[key] = value

    ###
    ## you should use this as your primary means of identifying
    ## a model uniquely; e.g. in object lookups etc
    ###
    getIdentifier: ->
        return null

module.exports = Base
