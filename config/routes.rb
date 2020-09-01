Rails.application.routes.draw do

    namespace :api do
      namespace :v1 do
        resources :posts, only: [:index, :create, :show]
        resources :users, only: [:create, :index]
        resources :comments, only: [:create]
        post '/login', to: 'auth#create'
        get '/profile', to: 'users#profile'
        post '/togglefollow', to: 'users#toggle_follow'
        get '/:username/posts', to: "posts#user_index"
        get '/:username', to: "users#user_profile"
      end
    end
end
