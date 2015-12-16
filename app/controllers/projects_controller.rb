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
    @errors = {
      name: ["this is fuct"]
    }
    render :new
  end

  def validate_project
    # TODO: validate project fields (name, url, description)
  end
end
