class UpdateProject < BaseInteractor

  def call
    require_context :project

    form = ProjectForm.for_update(params, context.project)

    if form.valid?
      context.project.update_attributes!(params)
    else
      context.fail! errors: form.errors
    end
  end
end
