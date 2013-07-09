SWorDNostro::Application.routes.draw do

  root :to => 'pages#home'


  # named routes for static pages, signup, login and logout
  match '/about', to: 'pages#about'
  match '/contact', to: 'pages#contact'
  match '/faq', to: 'pages#faq'
  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  # signout should be performed by using the HTTP DELETE request

  match '/signout', to: 'sessions#destroy', via: :delete


  #per OAuth2
  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/failure', to: 'users#failure'

  # routes for the Users controller (default plus following and followers)
  resources :users do
    member do
      get :following, :followers # ex.: get /users/1/followers
    end

    collection do
      get :search, :homepage
    end
  end

 # default routes for the Sessions controller (only new, create and destroy)
  resources :sessions, only: [:new, :create, :destroy]

  resources :itinerarios do
    member do
      post :new
    end

    collection do
      get :search2
      end
  end

 match 'users/itinerarios/all', to: 'itinerarios#all'
 match 'users/itinerarios/allfollowing', to: 'itinerarios#allfollowing'
 match 'users/itinerarios/classifica', to: 'itinerarios#classifica'



  resources :hotels


  resources :ristorantes


  resources :luogos


  # default routes for the Relationship controller (only create and destroy) - needed to build follow/unfollow relations
  resources :relationships, only: [:create, :destroy]

  resources :votatos




  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
