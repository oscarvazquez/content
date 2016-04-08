Rails.application.routes.draw do
  root "application#index"

  post 'auth' => 'auth#authenticate'	
  
  get "/users/check_email/:token" => "users#email_verification"

  post "/users/add_location" => "users#add_location"

  resource :sessions, only: [:create, :destroy]

  resource :users, only: [:create]

  get 'users/:id' => "users#show"

  get 'auth/:provider/callback', to: 'sessions#createO'
  get 'auth/failure', to: redirect('/')
  
  get '*path' => 'application#index'
end
