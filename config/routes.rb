IsfitParticipant::Application.routes.draw do
  get 'dashboard', to: 'dashboard#index'

  get 'landing/index'

  devise_for :users, :skip => [:sessions]
  as :user do
    get 'login' => 'devise/sessions#new', :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session
    get 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session

    get 'signup' => 'devise/registrations#new', :as => :new_user_registration
    post 'signup' => 'devise/registrations#create', :as => :user_registration
  end

  resources :users do
    resource :dialogue_application, path: 'applications/dialogue'
    resource :profile, only: [:new, :create]
    member do
      post :add_role
      post :remove_role
    end
  end

  resources :answers

  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  resources :information_categories
  resources :information_pages
  resources :workshops do
    member do
      get "participants"
      get "allergies"
      get "attendance_list"
    end
  end
  resources :articles
  post "search/index"

  resources :events
  
  resources :hosts do
    collection do
      match 'index' => 'hosts#index', :via => [:get, :post]
      match '/:id' => 'hosts#show', :via => [:get, :post]
    end
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

  root :to => 'landing#index'
end
