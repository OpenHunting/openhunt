class ProjectsController < ApplicationController
  before_filter :require_user, only: [:new, :create, :validate, :vote, :unvote]

  def index
    @projects = Project.featured(params[:page]).includes(:user).to_a
    if current_user.present?
      @vote_ids = current_user.match_votes(@projects.map(&:id))
    end
  end

  def vote

  end

  def unvote

  end

  def new

  end

  def create
    form = ProjectForm.new(params)
    if form.valid?
      project = Project.new(form.attributes)
      project.user = current_user
      project.save!
      current_user.vote(project)
      redirect_to "/"
    else
      @errors = form.errors
      render :new
    end
  end

  def validate_project
    # TODO: validate project fields (name, url, description)
  end
end
