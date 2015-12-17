class UsersController < ApplicationController
  def show
    load_user

    load_voted_projects
    load_submitted_projects

    if current_user.present?
      @vote_ids = current_user.match_votes((@voted_projects+@submitted_projects).map(&:id))
    end
  end

  protected
  def load_user
    @user = User.where(screen_name: params[:screen_name]).first
  end

  def load_voted_projects
    @voted_projects = @user.voted_projects.order(:votes_count => :desc)
  end

  def load_submitted_projects
    @submitted_projects = @user.submitted_projects.order(:votes_count => :desc)
  end
end
