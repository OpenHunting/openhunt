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

    is_today = (time.at_midnight == now.at_midnight)

    # saturday or sunday
    if time.weekend?
      "#{'This' if is_today} Weekend"
    elsif is_today
      "Today"
    elsif (time - 1.day).at_midnight == (now - 1.day).at_midnight
      "Yesterday"
    else
      time.strftime("%A")
    end
  end

  def date_human(past)
    present = DateTime.now

    distance_of_time_in_words(past, present) + ' ago.'
  end

  def audit_description(log)
    result = case log.item_type
    when "update_project"
      "updated the project (<a href='#{log.target_url}'>#{h log.target_display}</a>)"
    when "make_moderator"
      "marked the user (<a href='#{log.target_url}'>@#{h log.target_display}</a>) as <strong>moderator</strong>."
    when "remove_moderator"
      "remove the user (<a href='#{log.target_url}'>@#{h log.target_display}</a>) as <strong>moderator</strong>."
    when "ban_user"
      "marked the user (<a href='#{log.target_url}'>@#{h log.target_display}</a>) as <strong>banned</strong>."
    when "unban_user"
      "marked the user (<a href='#{log.target_url}'>@#{h log.target_display}</a>) as <strong>unbanned</strong>."
    when "hide_project"
      "marked the project (<a href='#{log.target_url}'>#{h log.target_display}</a>) as <strong>spam</strong>."
    when "unhide_project"
      "restored the project (<a href='#{log.target_url}'>#{h log.target_display}</a>) as <strong>not spam</strong>."
    else
      "[UNKNOWN TYPE: #{h log.item_type}]"
    end

    result.html_safe
  end

  def body_css(css_class = nil)
    @body_css ||= []
    if css_class.present?
      @body_css << css_class
    end

    @body_css.join(" ")
  end

  def content_nav_link(title, action)
    if current_page?(controller: "pages", action: action)
      content_tag :strong, title
    else
      link_to title, url_for(controller: "pages", action: action)
    end
  end
end
