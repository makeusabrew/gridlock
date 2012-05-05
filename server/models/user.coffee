Base     = require "./base"
mongoose = require "mongoose"
Schema   = mongoose.Schema
ObjectId = mongoose.ObjectId

UserSchema = new Schema({
    twitter_id: Number,
    profile_image_url: String,
    name: String,
    friends_count: Number,
    followers_count: Number,
    description: String,
    screen_name: String,
    location: String,
    twitter_identity: String
})

UserModel = mongoose.model "UserModel", UserSchema

class User extends Base
    constructor: (properties)->
        if typeof properties is 'object'
            @model = new UserModel properties, true
        else
            @model = new UserModel()

    createFromValues: (data, cb) ->
        @set 'twitter_id', data.id
        @set 'profile_image_url', data.profile_image_url
        @set 'name', data.name
        @set 'friends_count', data.friends_count
        @set 'followers_count', data.followers_count
        @set 'description', data.description
        @set 'screen_name', data.screen_name
        @set 'location', data.location
        @set 'twitter_identity', data._identity

        @model.save (err) ->
            cb err

    getIdentifier: ->
        return @get "twitter_id"

exports.User = User
exports.UserModel = UserModel
