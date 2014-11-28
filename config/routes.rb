IsfitParticipant::Application.routes.draw do
  namespace :faq do
    resources :categories, only: [:index, :edit, :create, :update, :destroy]
    resources :questions, only: [:index, :new, :edit, :create, :update, :destroy]

    root to: 'front#index'
  end

  get 'information', to: 'information#index'

  get 'flight-booking', to: redirect('http://conventionsplusbookings.staralliance.com/trips/StarHome.aspx?meetingcode=SK17S15'), as: 'flight_booking'

  resources :dialogue_applications
  
  resources :workshops, only: [:index, :show]

  get 'dashboard', to: 'dashboard#index'

  resources :workshop_applications, only: [:index, :show]
  resources :participants

  namespace :admin do
    resources :workshops  
    resources :users
    resources :countries, only: [:index, :edit, :update]
  end

  get 'waiting_list', to: 'waiting_list#show'
  put 'waiting_list', to: 'waiting_list#update'

  namespace :deadlines do
    get 'prepare_visa', to: 'prepare_visa#show'
    put 'prepare_visa', to: 'prepare_visa#update'

    get 'invitation', to: 'invitation#show'
    put 'invitation', to: 'invitation#update'
    get 'invitation/download', to: 'invitation#download'
    get 'invitation/download_financial', to: 'invitation#download_financial'
    get 'invitation/download_lor_travel_support', to: 'invitation#download_lor_travel_support'

    get 'applied_visa', to: 'applied_visa#show'
    put 'applied_visa', to: 'applied_visa#update'
  end

  namespace :review do
    resources :workshop_applications, as: :profiles, controller: :profiles, path: 'profiles', only: [:index, :show, :update] do
      get 'fetch', on: :collection
    end

    resources :workshop_applications, only: [:index, :show, :update] do
      get 'fetch', on: :collection
    end
  end

  namespace :settings do
    get 'user', to: 'user#edit', as: :edit_user
    put 'user', to: 'user#update'

    get 'password', to: 'password#edit', as: :edit_password
    put 'password', to: 'password#update'

    get 'profile/new', to: 'profile#new', as: :new_profile
    post 'profile', to: 'profile#create'
    get 'profile', to: 'profile#edit', as: :edit_profile
    put 'profile', to: 'profile#update'
  end

  namespace :applications do
    resource :dialogue, only: [:show, :create, :new, :update], controller: :dialogue
    resource :workshop, only: [:show, :create, :new, :update], controller: :workshop
  end

  devise_for :users, :skip => [:sessions, :registration]
  as :user do
    get 'login' => 'devise/sessions#new', :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session
    get 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session

    get 'apply' => 'apply#new', :as => :new_user_registration
    post 'apply' => 'apply#create', :as => :user_registration
  end

  resources :answers

  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  resources :information_categories
  resources :information_pages
  
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
