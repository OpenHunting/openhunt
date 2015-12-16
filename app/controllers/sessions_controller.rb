class SessionsController < ApplicationController
  def auth_start
    # TODO: store stuff in session that needs to be completed
  end

  def auth_callback

  end

  def auth_success
    if params[:oauth_token].blank? or params[:oauth_secret].blank?
      render json: {
        msg: "Pass in oauth_token and oauth_secret for twitter"
      }, status: :unprocessable_entity
      return
    end

    twitter_auth = get_twitter_auth(params[:oauth_token], params[:oauth_secret])

    # JSON
    # TODO: process any items that are in session (for after login)

    render json: {
      redirect_to: "/"
    }
  end

  protected

  def get_twitter_auth(oauth_token, oauth_secret)

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Settings.twitter.key
      config.consumer_secret     = Settings.twitter.secret
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end

    client.user.to_hash
  end
end
