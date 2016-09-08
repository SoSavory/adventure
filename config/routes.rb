Rails.application.routes.draw do
  root to: "statics#index"

  resources :pages
    get 'add_page', action: :add_page, controller: 'pages'
    get 'show_child_pages', action: :show_child_pages, controller: 'pages'
  resources :stories
  resources :statics





end
