Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, Settings.twitter_key, Settings.twitter_secret
end
