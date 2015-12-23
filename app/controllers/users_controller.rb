class UsersController < ApplicationController
  before_filter :require_user, only: [:ban, :unban, :make_moderator, :remove_moderator, :edit, :update]

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

  def edit
    @user = current_user

  end

  def update
    @user = current_user
    
  end

  def ban
    load_user

    result = current_user.ban_user(@user)
    redirect_url = "/@#{@user.screen_name}"
    redirect_to "/audit/#{result.id}/edit?redirect_url=#{redirect_url}"
  end

  def unban
    load_user

    result = current_user.unban_user(@user)
    redirect_url = "/@#{@user.screen_name}"
    redirect_to "/audit/#{result.id}/edit?redirect_url=#{redirect_url}"
  end

  def make_moderator
    load_user

    result = current_user.make_moderator(@user)
    redirect_url = "/@#{@user.screen_name}"
    redirect_to "/audit/#{result.id}/edit?redirect_url=#{redirect_url}"
  end

  def remove_moderator
    load_user

    result = current_user.remove_moderator(@user)
    redirect_url = "/@#{@user.screen_name}"
    redirect_to "/audit/#{result.id}/edit?redirect_url=#{redirect_url}"
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
