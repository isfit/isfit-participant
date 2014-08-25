IsfitParticipant::Application.routes.draw do
  
  resources :workshops, only: [:index, :show]

  get 'dashboard', to: 'dashboard#index'

  namespace :admin do
    resources :workshops  
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
    get 'motivation', to: 'motivation#edit', as: :edit_motivation
    put 'motivation', to: 'motivation#update'

    get 'dialogue/new', to: 'dialogue#new', as: :new_dialogue
    post 'dialogue', to: 'dialogue#create'
    get 'dialogue', to: 'dialogue#edit', as: :edit_dialogue
    put 'dialogue', to: 'dialogue#update'

    resource :workshop, only: [:show, :create, :new, :update], controller: :workshop
  end

  devise_for :users, :skip => [:sessions]
  as :user do
    get 'login' => 'devise/sessions#new', :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session
    get 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session

    get 'signup' => 'devise/registrations#new', :as => :new_user_registration
    post 'signup' => 'devise/registrations#create', :as => :user_registration
  end

  resources :answers

  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  resources :information_categories
  resources :information_pages
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
