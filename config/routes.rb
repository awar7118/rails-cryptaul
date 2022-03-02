Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :cryptos, only: %i[index show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
