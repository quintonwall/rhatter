OmniauthDemo::Application.routes.draw do
  
  #explicitly added the leading / for routes. jquerymobile and rails dont always
  # play together very well otherwise
  
  get "/chatter_posts/newcomment"
  
  post "/chatter_posts/addcomment"
  
  post "/chatter_posts/newstatus"

  get "/chatter_posts/like"

  get "/my_chatter/home"
  
  get "/my_chatter/newstatus"
  
  get "/my_chatter/myfollowers"
  
  get "/my_chatter/imfollowing"
  
  get "/my_chatter/mynewsfeed"
  
  get "/my_chatter/mygroups"

  get "/home/welcome"

  get "/home/goodbye"

  get "sessions/create"
  
  #get "sessions/authenticate"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  #add our oauth redirect route
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#fail'

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
   root :to => "sessions#authenticate"
   #root :to => "/auth/forcedotcom"
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
