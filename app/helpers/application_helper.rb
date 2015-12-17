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

    if @errors[key].present?
      "has-error"
    end
  end

  def error_messages(key)
    return unless @errors.present?

    Array.wrap(@errors[key])
  end

  def field_errors(key)
    messages = error_messages(key)
    return unless messages.present?

    %{
      <p class="help-block">#{h messages.join(", ")}</p>
    }.html_safe
  end

  def upvoted?(project_id)
    return false unless @vote_ids.present?

    @vote_ids.include?(project_id)
  end

  def project_vote_href(project)

  end

  def project_vote_attributes(project)
    result = {}


    if current_user.present?
      result[:href] = "/vote/#{project.slug}"
      if upvoted?(project.id)
        result[:class] = "on ajax"
      else
        result[:class] = "ajax"
      end
    else
      result[:href] = "/login?vote=#{project.slug}"
    end


    result
  end

  def date_display(time)
    if time.is_a?(String)
      time = Project.parse_bucket(time)
    end

    now = Time.now.in_time_zone(Settings.base_timezone)
    if time.at_midnight == now.at_midnight
      "Today"
    elsif (time - 1.day).at_midnight == (now - 1.day).at_midnight
      "Yesterday"
    else
      time.strftime("%A")
    end
  end

  def audit_description(log)
    case log.item_type
    when "ban_user"
      "marked the user (<strong>@#{log.target_display}</strong>) as <strong>banned</strong>."
    when "hide_project"
      "marked the project (<strong>#{log.target_display}</strong>) as <strong>spam</strong>."
    else
      "[UNKNOWN TYPE: #{log.item_type}]"
    end
  end
end
