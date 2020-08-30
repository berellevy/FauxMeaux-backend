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

    def profile
        render json: { user: current_user.profile}, status: :accepted
    end

    private

    def user_params
        params.require(:user).permit(:name, :username, :password)
    end
    
    
end
