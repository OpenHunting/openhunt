Rails.application.routes.draw do
  get "/new" => "projects#new"

  get "/vote/:id" => "projects#vote"
  delete "/vote/:id" => "projects#unvote"

  get "/about" => "pages#about"

  get "/login" => "sessions#auth_start", as: :auth_start
  get "/login/callback" => "sessions#auth_callback", as: :auth_callback
  post "/login/success" => "sessions#auth_success", as: :auth_success

  root "projects#index"
end
