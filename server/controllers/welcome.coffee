WelcomeController =
    io: null,

    authUser: (socket, data) ->
        # do user auth
        console.log data

    proceedToLobby: (socket) ->
        socket.emit "state:change", "lobby"
        
module.exports = WelcomeController
