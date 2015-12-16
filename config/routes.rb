Rails.application.routes.draw do
  get "/new" => "projects#new"

  get "/vote/:id" => "projects#vote"
  delete "/vote/:id" => "projects#unvote"

  get "/about" => "pages#about"

  root "projects#index"
end
