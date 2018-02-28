Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  resources :seating_plans, only: [:create ] do
    resources :tables, only: [:index]

  end


  resources :participants, only: [:create, :update, :destroy], shallow: true

  resources :relationships, only: [:create]

  patch 'participants/swap'
  put 'participants/swap'

  get 'participants/find_for_modal', as: "find_for_modal"

end
