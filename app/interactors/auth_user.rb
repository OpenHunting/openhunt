class AuthUser < BaseInteractor

  def call
    require_context(:auth)

    auth = context.auth

    # TODO: make this support other providers

    user = User.find_or_initialize_by({
      twitter_id: auth.uid
    })

    # set data from twitter auth
    user.screen_name = auth.info.nickname
    user.name = auth.info.name
    user.profile_image_url = auth.info.image
    user.twitter_id = auth.uid
    user.location = auth.info.location
    user.save!

    context.user = user
  end

end
