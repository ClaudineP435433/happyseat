Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  resources :seating_plans, only: [:create, :show ] do
    resources :tables, only: [:index, :update]
    resources :participants, only: [:create] do
      patch 'swap'
      put 'swap'
    end
    resources :relationships, only: [:create]
    get 'export'
 end

  resources :participants, only: [:update, :destroy], shallow: true

  get 'tables/find_for_modal', as: "find_for_modal"



end
