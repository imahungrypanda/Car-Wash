Rails.application.routes.draw do
  root 'vehicles#index'
  resources :vehicles, only: [ :index, :show, :new, :create, :update, :destroy ]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
