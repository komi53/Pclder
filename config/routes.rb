Rails.application.routes.draw do
  get 'homes/top'
  get 'rooms/index'
  get 'rooms/deleted' => 'rooms#deleted'
  get 'goods/search' => 'goods#search'
  root to: 'homes#top'
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]
  resources :posts do
  resource :favorites, only: [:create, :destroy]
  resources :post_comments, only: [:create, :destroy]
  get 'search', on: :collection
  get 'ranking', on: :collection
  end
  scope module: :users do
    devise_for :users
  end
  patch "users/leave" => "users#leave"
  get "users/confirm" => "users#confirm"
  resources :users, only:[:index, :show, :edit, :update] do
    get 'search', on: :collection
    resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
  end
  resources :notifications, only: :index
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
