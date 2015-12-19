Rails.application.routes.draw do
  get "/new" => "projects#new"
  post "/new" => "projects#create"
  get "/validate" => "projects#validate_project"
  get "/date/:bucket" => "projects#bucket"

  get "/feedback/:slug" => "projects#feedback"
  post "/feedback/:slug" => "projects#set_feedback"

  post "/hide/:slug" => "projects#hide"
  post "/unhide/:slug" => "projects#unhide"

  get "/vote/:slug" => "projects#vote_confirm"
  post "/vote/:slug" => "projects#vote"
  delete "/vote/:slug" => "projects#unvote"

  get "/audit" => "pages#audit_log"

  get "/about" => "pages#about"
  get "/people" => "pages#people"
  get "/faq" => "pages#faq"
  get "/differences" => "pages#differences"
  get "/governance" => "pages#governance"
  get "/@:screen_name" => "users#show"
  post "/ban/@:screen_name" => "users#ban"
  post "/unban/@:screen_name" => "users#unban"
  post "/make_moderator/@:screen_name" => "users#make_moderator"
  post "/remove_moderator/@:screen_name" => "users#remove_moderator"

  get "/logout" => "sessions#logout"
  post "/logout" => "sessions#logout_complete"
  delete "/logout" => "sessions#logout_complete"
  get "/login" => "sessions#auth_start", as: :auth_start
  get "/login/callback" => "sessions#auth_callback", as: :auth_callback
  post "/login/success" => "sessions#auth_success", as: :auth_success

  get "/recent" => "projects#recent", format: [:atom, :rss]
  get "/popular" => "projects#index", format: [:atom, :rss]

  root "projects#index"
end
