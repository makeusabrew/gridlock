module.exports = (data) ->
    $(".chat-inner").append "
        <div>
            <time>#{data.timestamp}</time>
            <span class=author>#{data.author}</span>
            <span class=message>#{data.message}</span>
        </div>"
