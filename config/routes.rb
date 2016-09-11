Rails.application.routes.draw do
  devise_for :users
  root to: "stories#index"

  resources :pages
    get 'add_page', action: :add_page, controller: 'pages'
    get 'show_child_pages', action: :show_child_pages, controller: 'pages'
  resources :stories
  resources :statics
  resources :users





end
