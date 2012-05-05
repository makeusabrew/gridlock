jade = require "jade"
fs   = require "fs"

compiledStates = {}

StaticController =
    fetchState: (state, cb) ->
        if not compiledStates[state]?
            filename = "#{__dirname}/../views/states/#{state}.jade"
            data = fs.readFile filename, (err, data) ->
                fn = jade.compile data, {filename: filename}
                compiledStates[state] = fn()
                cb compiledStates[state]
        else
            cb compiledStates[state]

module.exports = StaticController
