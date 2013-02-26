Rails.application.routes.draw do

  namespace :eribium do
    root to: "base#default"
    get "dashboard", to: "dashboard#index", as: :dashboard

    resources :namespaces
    resources :workspaces
    resources :users
    resources :roles
  end

end
