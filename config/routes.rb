Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :seating_plans, only: [:create ] do
    resources :tables, only: [:index]

  end

  resources :tables, only: [] do
    resources :participants, only: [:create, :update, :destroy], shallow: true
  end

  resources :relationships, only: [:create]

  patch 'participants/swap'
  put 'participants/swap'

end
