Rails.application.routes.draw do

    namespace :api do
      namespace :v1 do
        resources :posts, only: [:create, :show]
        resources :users, only: [:create, :index, :update]
        resources :comments, only: [:create]
        resources :views, only: [:update]
        get '/feed/:page_num', to: 'posts#index'
        post '/login', to: 'auth#create'
        get '/profile', to: 'users#profile'
        post '/togglefollow', to: 'users#toggle_follow'
        get ':username/followers', to: 'users#followers'
        get ':username/followees', to: 'users#followees'
        get '/:username/posts/:page_num', to: "posts#user_index"
        get '/:username', to: "users#user_profile"
        post '/search', to: "users#search"
      end
    end
end
