class ProjectsController < ApplicationController
  before_filter :require_user, only: [:new, :create, :vote, :unvote]

  def index

  end

  def vote

  end

  def unvote

  end

  def new

  end

  def create
    
  end
end
