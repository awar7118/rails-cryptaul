Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :cryptos, only: [:index, :show] do
    resources :holdings, only: [:create, :update]
    resources :watchlists, only: [:create]
  end

  resources :holdings, only: [:index, :update]
  resources :watchlists, only: [:index, :destroy]

  get 'my_dashboard', to: 'holdings#index'
  get 'articles', to: 'pages#articles'
  # get 'my_dashboard/:id', to: 'holdings#advance_date', as: 'change_simulation'
  get 'my_dashboard/:id', to: 'holdings#advance_date_week', as: 'change_simulation_week'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
