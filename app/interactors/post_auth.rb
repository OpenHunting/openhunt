# go through session items post login and perform actions (such as vote, etc)
class PostAuth < BaseInteractor

  def call
    require_context(:session)
    require_context(:user)

    # find project the user was voting on, and vote it up automatically
    vote_project_id = context.session[:vote_project_id]
    context.session[:vote_project_id] = nil

    if vote_project_id.present?
      project = Project.where(id: vote_project_id).first
      context.user.vote(project)
    end

  end
end
