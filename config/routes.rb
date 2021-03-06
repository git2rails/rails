RailsServer::Application.routes.draw do
  
  devise_for :users
  
  namespace :api do
    devise_scope :user do
      get "users/sign_up", to: "users/registrations#create"
      get "users/sign_in", to: "users/sessions#create"
      get "users/show", to: "users/users#show"
    end
    
    post "friends/suggest"
    post "friends/accept"
    post "friends/block"
    get "friends/show"
        
    post "profiles/update"
    post "profiles/update_avatar"
    post "profiles/update_email_password"
    
    post "posts/create"
    get "posts/index"
    
    get "apps/index"
    
    post "messages/create"
    post "messages/destroy"
    get "messages/show"   
    
    resources :apps do 
      get "posts/index"
      post "posts/update"
      post "posts/destroy"
      get "ratings/index"
      post "ratings/update"
      post "ratings/destroy"
    end
    
    resources :posts do 
      get "comments/index"
      post "comments/update"
      post "comments/destroy"
    end
  end
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
