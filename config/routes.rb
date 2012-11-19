IsfitParticipant::Application.routes.draw do
  resources :answers
  resources :applications do
    collection do
      get "grade1"
      match 'grade2' => 'applications#grade2', :via => [:get, :post], :as => :grade2
      get "workshop_stats"
      get "country_stats"
      match 'search' => 'applications#search', :via => [:get, :post], :as => :search
      match 'stats' => 'applications#stats', :via => [:get, :post], :as => :stats
      match "duplicates" => "applications#duplicates_index", via: :get, :as => "duplicates"
    end
    member do
      get "selection"
      post "save_selection"
      post "select_app"
      get "grade_app"
      post "set_grade"
      get "duplicates"
    end
  end

  resources :control_panels, :only => [:index, :edit, :update]

  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  resources :information_categories
  resources :information_pages
  resources :workshops
  resources :articles
  post "search/index"
  devise_for :users

  resources :events
  
  resources :hosts do
    member do
      get "add_bed"
      get "remove_bed"
    end
  end

  resources :deadlines
  
  match 'change_password' => 'changepasswords#edit_password', :as => :change_password
  match 'change_password/update_password' => 'changepasswords#update_password', :as => :update_password

  resources :roles do
    member do
      get "impersonate"
    end
  end

  resources :questions do
    collection do 
      post "q_status"
      get "q_status"
		end
		member do
			get "resolve"
    end
    resources :answers
  end
  resources :functionaries
  match 'participants/:id/host/:host_id' => 'participants#match_host', :as => :add_host
  resources :participants do
    collection do
      get "validate_deadline"
      get "mail_to_search_results"
      get "deadlines_and_functionaries"
      match 'search' => 'participants#search', :via => [:get, :post], :as => :search
      match 'index' => 'participants#index', :via => [:get, :post]
      get "stats"
      get 'graphics'
    end
    member do
      post "approve_deadline"
      get "check_deadline"
      get "check_in"
      get "check_out"
      get "deadlines"
      post "deadlines_handler"
      get "failed_deadline"
      get "travel_support"
      get "letter_of_recommendation"
      get "isfit_transportation"
      get "impersonate"
      get "invitation"
      post "remove_deadline"
      get "secure"
      get "desecure"
      get "ignore"
      get "unignore"
      get "activate"
      get "deactivate"
      get :match
    end
  end

  root :to => "home#index"
  
  # map.username_link 'profile/:username', :controller => 'users', :action => 'show_profile'

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
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
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
  #       get :recent, :on => :collection
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
