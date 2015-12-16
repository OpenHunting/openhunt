class ProjectsController < ApplicationController
  before_filter :require_user, only: [:new, :create, :validate, :vote, :unvote]

  def index
    @projects = Project.featured(params[:page]).includes(:user).to_a
    if current_user.present?
      @vote_ids = current_user.match_votes(@projects.map(&:id))
    end
  end

  def vote_confirm
    get_project  
  end

  def vote
    get_project

    current_user.vote(@project)

    respond_to do |format|
      format.html do
        flash[:message] = "Your vote has been counted."

        # TODO: redirect to the project detail page instead
        redirect_to "/"
      end
      format.json do
        render json: @project, root: "project"
      end
    end

  end

  def unvote
    get_project

    current_user.unvote(@project)

    respond_to do |format|
      format.html do
        flash[:message] = "Your vote has been removed."

        # TODO: redirect to the project detail page instead
        redirect_to "/"
      end
      format.json do
        render json: @project, root: "project"
      end
    end

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

  protected

  def get_project
    @project = Project.where(id: params[:id]).first
  end
end
