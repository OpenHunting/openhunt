class UsersController < ApplicationController
  def show
    load_user

    load_voted_projects
    load_submitted_projects

  end

  protected
  def load_user
    @user = User.where(screen_name: params[:screen_name]).first
  end

  def load_voted_projects
    # TODO
  end

  def load_submitted_projects
    # TODO
  end
end
