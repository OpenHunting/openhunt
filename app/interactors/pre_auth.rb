# store param variables into session before login (so we can act on them after login)
class PreAuth < BaseInteractor
  def call
    require_context(:params)
    require_context(:session)

    # go through session items and store actons for later (such as vote, etc)
    context.session[:vote_project_id] = context.params[:vote]

    # save redirect_to
    context.session[:redirect_to] = context.params[:redirect_ffto]
  end
end
