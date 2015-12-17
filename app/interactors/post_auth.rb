# go through session items post login and perform actions (such as vote, etc)
class PostAuth < BaseInteractor

  def call
    require_context(:session)
    require_context(:user)

    # find project the user was voting on, and vote it up automatically
    vote_project_slug = session[:vote_project_slug]
    session[:vote_project_slug] = nil

    if vote_project_slug.present?
      project = Project.where(slug: vote_project_slug).first
      context.user.vote(project)
    end

    # set redirect_to
    context.redirect_to = session[:redirect_to].presence
  end

  def session
    context.session
  end
end
