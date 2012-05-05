loadedSounds = {}
aliases = {}
muted = false
booted = false
available = (typeof Audio is 'function')

SoundManager =
    toggleSounds: ->
        muted = !muted

    mute: ->
        muted = true

    unmute: ->
        muted = false

    loadSound: (path, alias) ->
        return if not available

        sound = new Audio path
        sound.load()

        loadedSounds[path] = sound

        aliases[alias] = path if alias?

    playSound: (path) ->
        return if not available or muted

        if loadedSounds[path] is undefined and aliases[path] is not undefined
            path = aliases[path]

        if loadedSounds[path] is undefined
            return

        loadedSounds[path].play()

module.exports = SoundManager
