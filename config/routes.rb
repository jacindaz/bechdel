Rails.application.routes.draw do
  devise_for :models
  resources :movies, only: [:index, :show, :new, :create] do
    resources :votes, only: [:new, :create]
    resources :comments, only: [:new, :create]
  end

  root 'movies#index'
end
