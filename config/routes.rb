Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :dashboard do
    collection do
      get :buttons
      get :alerts
      get :attributes
      get :avatar
    end
  end

  root to: "dashboard#index"
end
