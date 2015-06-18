Rails.application.routes.draw do

  get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"

  delete "catalog_wine_varieties/:id" => "catalogs#destroy_wine_variety"
  post   "add_new_wine_variety" => "catalogs#add_new_wine_variety"

  root 'main#index'

  resources :news
  resources :news_attachments
  resources :categories
  resources :countries
  resources :regions
  resources :manufacturers
  resources :colors
  resources :wine_varieties
  resources :catalogs
  resources :types
  resources :catalog_wine_varieties
  resources :users
  resources :sessions
  resources :imports
  resources :export_tos

  # get "/:idd" => "main#index"

end
