class AuditLogsController < ApplicationController
  before_filter :require_moderator, only: [:edit, :update]
  
  def index
    @audit_logs = AuditLog.all.includes(:moderator).order(:created_at => :desc).limit(100)
    # TODO: paginate
  end

  def edit
    load_log
  end

  def update

    load_log

    @log.note = params[:note]

    if @log.save!
      redirect_to(params[:redirect_url] || '/audit')
    else
      @errors = @log.errors
      render :edit
    end
  end

  protected
  def load_log
    @log = AuditLog.where(id: params[:id]).first
  end

  def require_moderator
    unless current_user.try(:moderator?)
      flash[:alert] = "Only moderators can access this page."
      redirect_to "/"
    end
  end

end
