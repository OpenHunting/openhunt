module ApplicationHelper
  def react_page(page, data = nil)
    data = (data || {}).with_indifferent_access
    raise(ArgumentError, "react_page only accepts a hash for it's data") unless data.is_a?(Hash)

    # merge data together
    common = (react_common || {}).with_indifferent_access
    react_props = common.merge(data).merge(page: page).serialize

    react_component("App.Layout", react_props)
  end

  def skip_header
    @skip_header = true
  end

  def skip_header?
    !!@skip_header
  end

  def error_class(key)
    return unless @errors.present?

    if @errors.with_indifferent_access[key].present?
      "has-error"
    end
  end

  def error_messages(key)
    return unless @errors.present?

    Array.wrap(@errors.with_indifferent_access[key])
  end

  def field_errors(key)
    messages = error_messages(key)
    return unless messages.present?

    %{
      <p class="help-block">#{h messages.join(", ")}</p>
    }.html_safe

  end
end
