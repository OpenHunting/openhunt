# store param variables into session before login (so we can act on them after login)
class PreAuth < BaseInteractor
  def call
    require_context(:params)
    require_context(:session)

    # go through session items and perform actions (such as vote, etc)
    context.session[:vote_project_id] = context.params[:vote_project_id]
  end
end
