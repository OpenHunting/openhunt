Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Settings.twitter_key, Settings.twitter_secret, {
    secure_image_url: true,
    image_size: 'bigger',
  }

end

OmniAuth.config.on_failure = Proc.new do |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
end
