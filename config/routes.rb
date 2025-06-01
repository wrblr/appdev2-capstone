Rails.application.routes.draw do
  # Root route
  root "memberships#index"

  # Devise routes with custom registration controller
  devise_for :users, controllers: {
            registrations: "users/registrations",
          }

  # Private user chat route
  resources :users, only: [] do
    member do
      get :chat, to: "messages#private_chat", as: :chat
    end
  end

  get 'messages/user/:id', to: 'messages#show', as: :user_chat

  # Translation, Language, Memberships, and Message routes
  resources :translations
  resources :languages
  resources :messages
  resources :memberships

  # Nested group messages
  resources :groups do
    resources :messages, only: [:new, :create, :index]
  end

  # Redirect /users to edit
  get "/users", to: redirect("/users/edit")

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
