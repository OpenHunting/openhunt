class ProjectsController < ApplicationController
  before_filter :require_user, only: [:new, :create, :validate, :vote, :unvote]

  def index

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
      project = Project.create(form.attributes)
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
