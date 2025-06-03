Rails.application.routes.draw do
  # Devise routes with custom registration controller
  devise_for :users, controllers: {
                       registrations: "users/registrations",
                     }

  # Root route
  root "memberships#index"

  # Private user-to-user chat route
  get "messages/:sender_id/:recipient_id", to: "messages#private_chat", as: :chat_user
  post "messages/:sender_id/:recipient_id", to: "messages#create", as: :chat_user_messages

  # resources :users, only: [] do
  #   member do
  #     # Private user-to-user chat route
  #     get "messages/:sender_id/:recipient_id", to: "messages#private_chat", as: :chat_user
  #     post "messages/:sender_id/:recipient_id", to: "messages#create", as: :chat_user_messages
  #   end
  # end

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
