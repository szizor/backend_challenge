Rolodex::Application.routes.draw do
  get "lists/index"
  get "contacts/index"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  get "contacts" => "contacts#index", :as => "contacts"
  get "lists" => "lists#index", :as => "lists"
  get "contacts_dashboard" =>"rolodex#index", :as=>"contacts_dashboard"
  root :to => "sessions#new"
  
  resources :users
  resources :sessions
  resources :contacts do
    post :image, :on => :member

    collection do
      post :image
      get :view
    end
  end
  resources :lists do
    collection do
      post :add_contact
      get :remove_contact
    end
  end
end
