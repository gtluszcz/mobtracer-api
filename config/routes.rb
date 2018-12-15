Rails.application.routes.draw do
  resources :locations, only: [:index, :create, :show]
end
