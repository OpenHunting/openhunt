Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, Settings.twitter_key, Settings.twitter_secret, {
    secure_image_url: true,
    image_size: 'bigger',
  }
end
