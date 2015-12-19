class UpdateProject < BaseInteractor

  def call
    require_context :project
    require_context :user

    context.form = ProjectForm.for_update(params, context.project)

    # TODO: store slug history in case we change name (so old slugs still go project)
    # ie: /asdf_old redirects to /asdf_new

    context.fail!(errors: "You are not allowed to do this") unless user_is_allowed?

    if context.form.valid?
      audit_action if context.user.moderator?
      context.project.update_attributes!(params)
    else
      context.fail! errors: context.form.errors
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
      target_display: context.form.name,
      target_url: "/feedback/#{context.project.reload.slug}"
    })
  end
end
