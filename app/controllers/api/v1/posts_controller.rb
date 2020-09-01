class Api::V1::PostsController < ApplicationController
    def index
        feed = current_user.feed
        render json: feed
    end

    def create
        post = Post.new(post_params)
        post.user = current_user
        if post.save
            render json: post.with_user_and_comments
        end
    end

    def show
        post = Post.find(params[:id])
        render json: post.with_user_and_comments
    end

    def user_index
        user = User.find_by(username: params[:username])
        posts = user.posts.order(updated_at: :desc)
        posts_hash = posts.map do |post| 
            post_hash = post.as_json
            post_hash[:comments] = post.comments.with_users
            post_hash
        end
        render json: posts_hash
    end
    
    

    private

    def post_params
        params.permit(:text, :img)
    end
    
    
    
end
