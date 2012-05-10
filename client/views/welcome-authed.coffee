module.exports = (data) ->
    str = "<p>Hi <b>#{data.screen_name}</b>! You're all set, so why not go ahead and
    enter the lobby?</p>
    <p><a href=# class='btn btn-primary enter-lobby'>Enter Lobby</a></p>"

    $(".auth-state").replaceWith str
