class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create
        puts user_params
        user = User.create(user_params)
        if user.valid?
            token = encode_token(user_id: user.id)
            render json: { user: user.profile, jwt: token, ok: true}
        else
            render json: { errors: user.errors } #status: :not_acceptable
        end   
    end

    def update
        user = User.find(params[:id])
        if user == current_user
            user.avatar = avatar_param[:avatar]
            user.save
            render json: {user: user_profile_details(user.username)}
        else
            render json: { error: :unauthorized}
        end
    end

    def profile
        render json: { user: current_user.profile}, status: :accepted
    end

    def index
        users = User.all
        render json: users
    end

    def user_profile_details(username)
        user = User.find_by(username: username)
        user_hash = user.profile
        user_hash[:follows_current_user] = user.is_following(current_user.id)
        user_hash[:followed_by_current_user] = user.is_followed_by(current_user.id)
        user_hash[:is_current_user] = user == current_user
        user_hash
    end

    def followers
        followers = User.find_by(username: params[:username]).followers.map { |u| u.profile}
        render json: followers
    end
    
    def followees
        followees = User.find_by(username: params[:username]).followees.map { |u| u.profile}
        render json: followees
    end
    

    def user_profile
        render json: { user: user_profile_details(params[:username]) } 
    end

    def toggle_follow
        user = User.find_by(username: toggle_follow_params[:username])
        unless user.is_followed_by(current_user.id)
           current_user.follow(user.id)
           render json: user_profile_details(user.username)
        else
            current_user.unfollow(user.id)
            render json: user_profile_details(user.username)
        end
    end

    def search
        users = User.search(search_params[:query]).map { |user| user.profile }
        render json: users
    end
    
    private

    def user_params
        params.require(:user).permit(:name, :username, :password)
    end

    def avatar_param
        params.permit(:avatar)
    end

    def toggle_follow_params
        params.require(:user).permit(:username)    
    end

    def search_params
        params.permit(:query)
    end
end
