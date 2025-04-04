Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to =>"homes#top"
  devise_for :users
  
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorite, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy] 
      get :follows, on: :member
      get :followers, on: :member
  end
  
  resources :searches, only: [:index]
  
  resources :rooms, only:[:create, :show] do
    resources :messages, only:[:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end