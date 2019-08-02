Rails.application.routes.draw do

  get 'password_resets/new'
  root "application#index"

  resources :users, except: [:index, :destroy]

  controller :sessions do
    get 'login' => :new, as: 'login'
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :password_resets, only: [:new, :create, :edit, :update]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
