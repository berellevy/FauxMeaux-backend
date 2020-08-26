class Api::V1::PostsController < ApplicationController
    def index
        feed = User.first.feed
        render json: feed
    end
    
end
