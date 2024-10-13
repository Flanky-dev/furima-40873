Rails.application.routes.draw do
  devise_for :users
  # トップページをitems#indexに設定
  root to: 'items#index'

  # itemsリソースのネストされたordersリソース
  resources :items, only: [:new, :create, :edit, :update, :show, :index, :destroy] do
    resources :orders, only: [:index, :create]
  end
end


