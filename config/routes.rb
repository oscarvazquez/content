Rails.application.routes.draw do
  root "application#index"

  post 'auth' => 'auth#authenticate'	
  
  get "/users/check_email/:token" => "users#email_verification"

  get "/users/profile/:id" => "users#profile"

  post "/users/add_location" => "users#add_location"

  post "/users/profile_picture" => "users#add_profile_picture"

  resource :sessions, only: [:create, :destroy]

  resources :users, only: [:create, :show]

  resources :comments, only: [:create, :destroy, :show]

  resources :likes, only: [:create, :destroy]

  resources :reviews, only: [:show]

  resources :subcategories, only: [:destroy, :create]

  resources :categories, only: [:destroy, :create]

  resources :posts, only: [:create, :destroy]

  resources :messages, only: [:create, :destroy]

  resources :businesses, only: [:index]

  get 'auth/:provider/callback', to: 'sessions#createO'
  get 'auth/failure', to: redirect('/')
  
  get '*path' => 'application#index'
end
