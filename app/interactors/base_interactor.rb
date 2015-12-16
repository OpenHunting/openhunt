class BaseInteractor
  include Interactor

  # checks if a field is in context, raises exception if not
  def require_context(field_name)
    if context.send(field_name).present?
      return true
    else
      raise "No #{field_name} param provided for #{self.class}"
      return false
    end
  end

  # checks if a field is in context, fail if not
  def validate_context(field_name, msg = nil)
    if context.send(field_name).present?
      return true
    else
      context.fail!({
        message: msg.presence || "#{field_name} param is required"
      })
    end
  end

  def params
    if context.params.blank?
      context.params = Util.indifferent({})
    end
    context.params
  end

end
