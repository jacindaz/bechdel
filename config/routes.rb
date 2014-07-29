Rails.application.routes.draw do

  devise_for :users
  root to: 'movies#index', :sort_by => 'bechdel_reviews'

  resources :movies, only: [:index, :show, :new, :create] do
    resources :votes, only: [:create, :update]
    resources :comments, only: [:create]
  end

  resources :bechdel, only: [:index]
  resources :analytics, only: [:index]
  resources :categories, only: [:index]
end
