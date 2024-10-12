Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items, only: [:new, :create, :edit, :update, :show, :index, :destroy]
  resources :items do
    resources :orders, only: [:index, :create]
  root to: 'orders#index'
  resources :orders, only:[:index, :create]
  end
end


