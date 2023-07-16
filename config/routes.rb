Rails.application.routes.draw do
  devise_for :users
  get 'data', to: 'data#index'
  root 'pages#index'

  post 'block_source', to: 'pages#block_source', as: 'block_source'
  patch 'unblock_source', to: 'pages#unblock_source', as: 'unblock_source'



end
