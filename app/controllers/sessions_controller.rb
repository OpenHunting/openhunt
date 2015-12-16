class SessionsController < ApplicationController
  def auth_start
    # TODO: store stuff in session that needs to be completed
  end

  def auth_callback

  end

  def auth_success
    # JSON 
    # TODO: process any items that are in session (for after login)
  end
end
