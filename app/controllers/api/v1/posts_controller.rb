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

    def show
        post = Post.find(params[:id])
        render json: post.with_user
    end

    def user_index
        user = User.find_by(username: params[:username])
        render json: user.posts.order(updated_at: :desc)
    end
    
    

    private

    def post_params
        params.permit(:text, :img)
    end
    
    
    
end
