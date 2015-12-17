class PagesController < ApplicationController
  def about

  end

  def audit_log
    @audit_logs = AuditLog.all.includes(:moderator).order(:created_at => :desc).limit(100)
    # TODO: paginate
  end

end
