Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root 'bests#index'
  get 'homes/about'
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
