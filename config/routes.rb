Rails.application.routes.draw do

  devise_for :users
  root to: 'movies#index'

  resources :movies, only: [:index, :show, :new, :create] do
    collection do
      get 'autocomplete'
    end
    resources :votes, only: [:create, :update]
    resources :comments, only: [:create]
  end

  resources :bechdel, only: [:index]
  resources :analytics, only: [:index]
  resources :categories, only: [:index]
end
