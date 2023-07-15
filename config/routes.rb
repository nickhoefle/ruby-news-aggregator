Rails.application.routes.draw do
  get 'data', to: 'data#index'
  root 'pages#index'
end
