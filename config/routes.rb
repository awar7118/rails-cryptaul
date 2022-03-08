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
  get 'jargonbuster', to: 'pages#jargonbuster'
  get :advance_date, to: 'holdings#advance_date', as: 'change_simulation'
  get :advance_date_week, to: 'holdings#advance_date_week', as: 'change_simulation_week'
  # get :advance_date_index, to: 'holdings#advance_date_index', as: 'change_simulation_index'
  # get :advance_date_week_index, to: 'holdings#advance_date_week_index', as: 'change_simulation_week_index'
  # get :advance_date_show, to: 'holdings#advance_date_show', as: 'change_simulation_show'
  # get :advance_date_week_show, to: 'holdings#advance_date_week_show', as: 'change_simulation_week_show'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
