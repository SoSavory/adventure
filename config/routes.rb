Rails.application.routes.draw do
  devise_for :users
  root to: "stories#index"

  resources :pages
    get 'add_page', action: :add_page, controller: 'pages'
    get 'show_child_pages', action: :show_child_pages, controller: 'pages'
    delete 'page/delete/:id', to: 'pages#delete', as: 'delete_page'
  resources :stories
    post 'publish_story/:id', to: 'stories#publish_story', as: 'publish_story'
    delete 'story/delete/:id', to: 'stories#delete', as: 'delete_story'
  resources :statics
  resources :users





end
