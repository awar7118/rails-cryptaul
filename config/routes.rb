Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :cryptos, only: [:index, :show] do
    resources :holdings, only: [:create, :update]
  end

  resources :holdings, only: :update

  get 'my_dashboard', to: 'holdings#index'
  get 'articles', to: 'pages#articles'
  get 'my_dashboard/:id', to: 'holdings#advance_date', as: 'change_simulation'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
