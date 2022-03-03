Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :cryptos, only: [:index, :show] do
    resources :holdings, only: [:create, :update]
  end
  get 'my_dashboard', to: 'pages#my_dashboard'
  get 'articles', to: 'pages#articles'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
