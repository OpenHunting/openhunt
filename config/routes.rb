Rails.application.routes.draw do

  # Projects
  get '/new' => 'projects#new'
  post '/new' => 'projects#create'
  get '/validate' => 'projects#validate_project'
  get '/date/:bucket' => 'projects#bucket'
  get '/edit/:slug' => 'projects#edit'
  patch '/update/:slug' => 'projects#update'
  get '/detail/:slug' => 'projects#detail'
  post '/feedback/:slug' => 'projects#set_feedback'
  post '/hide/:slug' => 'projects#hide'
  post '/unhide/:slug' => 'projects#unhide'
  get '/vote/:slug' => 'projects#vote_confirm'
  post '/vote/:slug' => 'projects#vote'
  delete '/vote/:slug' => 'projects#unvote'

  # Subscribe
  get '/subscribe' => 'list_subscribers#edit'
  get '/subscribe/success' => 'list_subscribers#success'
  post '/subscribe' => 'list_subscribers#update'
  get '/subscribe/confirm/:code' => 'list_subscribers#confirm'

  # Audit
  get '/audit' => 'audit_logs#index'
  get '/audit/:id/edit' => 'audit_logs#edit'
  patch '/audit/:id' => 'audit_logs#update'

  # Help
  get '/about' => 'help#about'
  get '/team' => 'help#team'
  get '/guidelines' => 'help#guidelines'
  get '/faqs' => 'help#faqs'
  get '/contact' => 'help#contact'

  # User
  get '/@:screen_name' => 'users#show'
  get '/settings' => 'users#edit'
  post '/settings' => 'users#update'
  post '/ban/@:screen_name' => 'users#ban'
  post '/unban/@:screen_name' => 'users#unban'
  post '/make_moderator/@:screen_name' => 'users#make_moderator'
  post '/remove_moderator/@:screen_name' => 'users#remove_moderator'

  # Session
  get '/logout' => 'sessions#logout'
  post '/logout' => 'sessions#logout_complete'
  delete '/logout' => 'sessions#logout_complete'
  get '/login' => 'sessions#auth_start', as: :auth_start
  get '/auth/:service/callback' => 'sessions#auth_callback', as: :auth_callback
  get '/auth/failure' => 'sessions#auth_failure'

  # Feeds
  get '/recent' => 'projects#recent', format: [:atom, :rss]
  get '/popular' => 'projects#index', format: [:atom, :rss]

  # Legacy
  get '/feedback/:slug' => 'projects#detail'

  if Rails.env.development?
    get '/test_flash' => 'pages#test_flash'
    get '/devauth(/:screen_name)' => 'pages#devauth'
  end

  root 'projects#index'

end
