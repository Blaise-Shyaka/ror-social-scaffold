Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  resources :friendships, only: %i[index create destroy] do
    member do
      put 'accept'
      delete 'reject'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
