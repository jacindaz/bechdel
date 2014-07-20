Rails.application.routes.draw do

  devise_for :users
  root to: 'movies#index'

  get '/movies_with_button', to: 'movies#index_with_button', as: 'movies_with_button'

  resources :movies, only: [:index, :show, :new, :create] do
    resources :votes, only: [:create, :update]
    resources :comments, only: [:create]
  end

  resources :bechdel, only: [:index]
  resources :analytics, only: [:index]
end
