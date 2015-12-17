class ProjectsController < ApplicationController
  before_filter :require_user, only: [:new, :create, :validate, :vote_confirm, :vote, :unvote]

  def index
    @bucket = Project.bucket(current_now)
    load_bucket(@bucket)

  end

  def bucket
    @bucket = params[:bucket]
    load_bucket(@bucket)

    if params[:partial]
      render partial: "projects/bucket", locals: {
        bucket: @bucket,
        projects: @projects
      }
    else
      render
    end
  end

  def vote_confirm
    load_project
  end

  def vote
    load_project

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
    load_project

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

  def feedback
    load_project
    load_feedback

    if params[:partial]
      render partial: "projects/feedback", project: @project, feedback: @feedback
    else
      redirect_to "/#open=#{@project.slug}"
    end
  end

  def set_feedback
    if current_user.blank?
      # save posted data in session
      session[:feedback] = {project_id: @project.id, anonymous: params[:anonymous], body: params[:body]}.to_json
      session[:redirect_to] = "/feedback/#{@project.slug}"
      redirect_to "/login"
      return
    end

    load_feedback

    # TODO
  end

  def validate_project
    # TODO: validate project fields (name, url, description), via ajax
  end

  protected

  def load_project
    @project = Project.where(slug: params[:slug]).first
  end

  def load_feedback
    if current_user.present?
      @feedback = Feedback.where({
        user_id: current_user.id,
        project_id: @project.id
      }).first
    end
  end

  def load_bucket(bucket)
    @projects = Project.for_bucket(bucket).includes(:user).to_a
    if current_user.present?
      @vote_ids = current_user.match_votes(@projects.map(&:id))
    end
  end
end
