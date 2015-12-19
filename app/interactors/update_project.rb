class UpdateProject < BaseInteractor

  def call
    require_context :project
    require_context :user

    form = ProjectForm.for_update(params, context.project)

    context.fail!(errors: "You are not allowed to do this") unless user_is_allowed?

    if form.valid?
      audit_action if context.user.moderator?
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

  def audit_action
    context.audit_log = AuditLog.create!({
      item_type: "update_project",
      moderator_id: context.user.id,
      target_id: context.project.id,
      target_type: "Project",
      target_display: context.project.name,
      target_url: "/feedback/#{context.project.slug}"
    })
  end
end
