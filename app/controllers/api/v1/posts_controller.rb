class Api::V1::PostsController < ApplicationController
    def index
        feed = current_user.feed(params[:page_num].to_i)
        render json: feed
    end

    def create
        post = Post.new(post_params)
        post.user = current_user
        if post.save
            view = View.create(post, current_user)
            render json: view
        end
    end

    def show
        post = Post.find(params[:id])
        view = View.create(post, current_user)
        render json: view
    end

    def user_index
        page_num = params[:page_num].to_i
        page_qty = 5
        offset = page_num * page_qty
        user = User.find_by(username: params[:username])
        posts = user.posts.order(updated_at: :desc).limit(page_qty).offset(offset)
        views = View.batch_create(current_user, posts)
        render json: views
    end
    
    

    private

    def post_params
        params.permit(:text, :img)
    end
    
    
    
end
