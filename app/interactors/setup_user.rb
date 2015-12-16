class SetupUser < BaseInteractor

  def call
    require_context(:twitter_auth)
    twitter_auth = context.twitter_auth

    user = User.find_or_initialize_by({
      twitter_id: twitter_auth[:id]
    })

    # set data from twitter auth
    user.screen_name = twitter_auth[:screen_name]
    user.name = twitter_auth[:name]
    user.profile_image_url = twitter_auth[:profile_image_url_https]
    user.twitter_id = twitter_auth[:id]
    user.location = twitter_auth[:location]
    user.save!

    context.user = user
  end

end
