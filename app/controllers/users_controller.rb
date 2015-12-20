class UsersController < ApplicationController
  before_filter :require_user, only: [:ban, :unban]

  def show
    load_user
    if @user.blank?
      redirect_to "/"
      return
    end

    load_voted_projects
    load_submitted_projects

    if current_user.present?
      @vote_ids = current_user.match_votes((@voted_projects+@submitted_projects).map(&:id))
    end
  end

  def ban
    load_user

    current_user.ban_user(@user)
    redirect_to "/@#{@user.screen_name}"
  end

  def unban
    load_user

    current_user.unban_user(@user)
    redirect_to "/@#{@user.screen_name}"
  end

  def make_moderator
    load_user

    current_user.make_moderator(@user)
    redirect_to "/@#{@user.screen_name}"
  end

  def remove_moderator
    load_user

    current_user.remove_moderator(@user)
    redirect_to "/@#{@user.screen_name}"
  end

  protected
  def load_user
    @user = User.where("lower(screen_name) =?", params[:screen_name]).first
  end

  def load_voted_projects
    @voted_projects = @user.voted_projects.order(:votes_count => :desc)
  end

  def load_submitted_projects
    @submitted_projects = @user.submitted_projects.order(:votes_count => :desc)
  end
end
