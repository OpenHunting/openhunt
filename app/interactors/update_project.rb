class UpdateProject < BaseInteractor

  def call
    require_context :project
    require_context :user

    form = ProjectForm.for_update(params, context.project)

    context.fail!(errors: "You are not allowed to do this") unless user_is_allowed?

    if form.valid?
      context.project.update_attributes!(params)
    else
      context.fail! errors: form.errors
    end
  end

  def user_is_allowed?
    return true if context.user.moderator?
    return true if context.user.is_submitter?(context.project)
    # TODO: check that submitter is within the allowed time period
    return false
  end
end
