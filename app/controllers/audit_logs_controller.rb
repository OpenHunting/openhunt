class AuditLogsController < ApplicationController
  before_filter :require_user, only: [:new, :create, :validate, :vote_confirm, :vote, :unvote, :hide, :unhide, :edit, :update]
  before_filter :require_moderator
  before_filter :set_rss_false

  def edit
    load_log
  end

  protected
  def load_log
    @log = AuditLog.where(id: params[:id]).first
  end

  def require_moderator
    current_user.moderator?
  end

  # NOTE: in application.html.haml, it tries to
  # autogenerate RSS and ATOM links.  But navigating
  # to the audit log controller, that breaks.
  # this is a hack to fix it.
  def set_rss_false
    @rss = false
  end
end
