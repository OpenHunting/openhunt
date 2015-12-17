Rails.application.routes.draw do
  get "/new" => "projects#new"
  post "/new" => "projects#create"
  get "/validate" => "projects#validate_project"
  get "/date/:bucket" => "projects#bucket"

  get "/feedback/:slug" => "projects#feedback"
  post "/feedback/:slug" => "projects#set_feedback"

  post "/hide/:slug" => "projects#hide"

  get "/vote/:slug" => "projects#vote_confirm"
  post "/vote/:slug" => "projects#vote"
  delete "/vote/:slug" => "projects#unvote"

  get "/audit" => "pages#audit_log"

  get "/about" => "pages#about"
  get "/@:screen_name" => "users#show"

  get "/logout" => "sessions#logout"
  post "/logout" => "sessions#logout_complete"
  delete "/logout" => "sessions#logout_complete"
  get "/login" => "sessions#auth_start", as: :auth_start
  get "/login/callback" => "sessions#auth_callback", as: :auth_callback
  post "/login/success" => "sessions#auth_success", as: :auth_success

  root "projects#index"
end
