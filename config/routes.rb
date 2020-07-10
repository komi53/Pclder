Rails.application.routes.draw do
  root to: 'posts#index'
  resources :posts do
  resource :favorites, only: [:create, :destroy]
  resources :post_comments, only: [:create, :destroy]
  end
  scope module: :users do
    devise_for :users
  end
  resources :users, only:[:show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
