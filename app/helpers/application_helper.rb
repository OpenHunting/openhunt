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
      result[:href] = "/vote/#{project.id}"
      if upvoted?(project.id)
        result[:class] = "on ajax"
      else
        result[:class] = "ajax"
      end
    else
      result[:href] = "/login?vote=#{project.id}"
    end


    result
  end

  def date_display(time)
    now = Time.now.in_time_zone(Settings.base_timezone)
    if time.at_midnight == now.at_midnight
      "Today"
    elsif (time - 1.day).at_midnight == (now - 1.day).at_midnight
      "Yesterday"
    else
      now.strftime("%A")
    end
  end
end
