UserModel = require("../models/user").UserModel
User = require("../models/user").User

WelcomeController =
    io: null,

    authUser: (socket, data) ->
        # do user auth
        UserModel.findOne {"twitter_id": data.id}, (err, doc) ->
            if doc is null
                # new user
                user = new User()
                user.createFromValues data, (err) ->
                    socket.setUser user
                    socket.emit "welcome:authed", user.model
            else
                user = new User doc
                socket.setUser user
                socket.emit "welcome:authed", doc

    proceedToLobby: (socket) ->
        socket.emit "state:change", "lobby"
        
module.exports = WelcomeController
