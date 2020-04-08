Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#top'
  get 'homes/about'
  get 'bests/genre_search'
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :favorites
    end
  end
  resources :bests do
    resource :favorites, only: [:create, :destroy]
    resource :best_comments, only: [:create, :destroy]
  end
end
