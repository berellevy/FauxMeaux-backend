class Api::V1::PostsController < ApplicationController
    def index
        feed = current_user.feed
        render json: feed
    end

    def create
        post = Post.new(post_params)
        post.user = current_user
        if post.save
            render json: post.with_user
        end
        
    end

    private

    def post_params
        params.permit(:text, :img_url)
    end
    
    
    
end
