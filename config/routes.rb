Rails.application.routes.draw do

  root "application#index"

  resources :users

  controller :sessions do
    get 'login' => :new, as: 'login'
    post 'login' => :create
    delete 'logout' => :destroy
  end

  # resources :sessions, only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
