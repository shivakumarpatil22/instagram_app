Rails.application.routes.draw do
  devise_for :users
  resources :posts
  root 'posts#index'
  get '/my_post' => 'posts#my_post'
  resources :friends
  post '/send_invite' => 'friends#send_invite'
  get '/friend_request' => 'friends#friend_request'
  post '/cancel_invite' => 'friends#cancel_invite'
  post '/accept_invite' => 'friends#accept_invite'
  get '/my_friends' => 'friends#my_friends'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
