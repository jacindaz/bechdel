Rails.application.routes.draw do

  devise_for :users
  root to: 'movies#index'

  resources :movies, only: [:index, :show, :new, :create] do
    resources :votes, only: [:create, :update]
    resources :comments, only: [:new, :create]
    resources :bechdelinfo, only: [:create]
  end

  resources :bechdel, only: [:index]

end
