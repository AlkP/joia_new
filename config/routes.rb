Rails.application.routes.draw do

  root 'main#index'

  get "destroy_wine_variety/:id" => "catalogs#destroy_wine_variety"
  post "add_new_wine_variety" => "catalogs#add_new_wine_variety"

  get "filter/:id/apply" => "filters#add_teenager"
  get "filter/:url/index" => "filters#show_full_filters"
  get "filter/:id/:type" => "filters#new"
  get "filter_destroy/:id/:type" => "filters#destroy"
  get "order/:id" => "filters#add_order"
  get "change_sort/:type" => "filters#change_sort"
  get "show_wine/:n1/:n2" => "filters#show_wine"
  get "show_more_stories/:n1/:n2" => "main#show_more_stories"

  delete "manufacturers/:id/del_slide" => "manufacturers#del_slide"
  delete "manufacturers/:id/del_logo" => "manufacturers#del_logo"

  post "send_country_sortable" => "countries#send_country_sortable"
  post "send_region_sortable" => "regions#send_region_sortable"
  post "send_story_sortable" => "stories#send_story_sortable"
  post "send_color_sortable" => "colors#send_color_sortable"
  post "send_search_category_sortable" => "search_categories#send_search_category_sortable"
  post "send_manufacturer_sortable" => "manufacturers#send_manufacturer_sortable"
  post "send_catalog_sortable" => "catalogs#send_catalog_sortable"

  resources :users
  resources :sessions
  resources :countries
  resources :regions
  resources :manufacturers
  resources :types
  resources :sugars
  resources :colors
  resources :search_categories
  resources :categories
  resources :wine_varieties
  resources :catalogs
  resources :imports
  resources :exports
  resources :stories

  resources :abouts
  resources :list_manufacturers
  resources :manufacturer_attachments
  resources :contacts

  get "countries/:id/edit" => "countries#edit"
  get "regions/:id/edit" => "regions#edit"
  get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"
  post "offer" => "exports#offer", :as => "offer"
  get "offers" => "exports#offer", :as => "offers"

  # Обработка всех исключений
  # match "*path" => redirect("/404.html"), :via => [:get, :patch, :post, :put, :delete]

  # example
  # resources :main
  # main_index_path	    GET	    /main(.:format)	            main#index
  #                     POST	  /main(.:format)	            main#create
  # new_main_path	      GET	    /main/new(.:format)	        main#new
  # edit_main_path	    GET	    /main/:id/edit(.:format)	  main#edit
  # main_path	          GET	    /main/:id(.:format)	        main#show
  #                     PATCH	  /main/:id(.:format)	        main#update
  #                     PUT	    /main/:id(.:format)	        main#update
  #                     DELETE	/main/:id(.:format)	        main#destroy

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
