# extension to allow using `.serialize` on all object, arrays, and active record relations
class ActiveRecord::Base

  # ActiveModelSerializers can bite my ass
  def self.serialize(obj)
    if obj.is_a?(Hash)
      new_obj = obj.dup
      new_obj.keys.each do |key|
        new_object[key] = new_object[key].serialize
      end
      new_object.as_json
    elsif obj.respond_to?(:map)
      obj.map{|i| serialize(i)}
    else
      "#{self.to_s}Serializer".constantize.new(obj).serializable_hash.as_json
    end
  rescue NameError => e
    Rails.logger.warn("No ActiveModelSerializer found for #{self.to_s}")
    obj.as_json
  end

  def serialize
    self.class.serialize(self)
  end

end

module Enumerable
  def serialize
    obj = self
    if obj.is_a?(Hash)
      new_obj = obj.dup
      new_obj.keys.each do |key|
        new_obj[key] = new_obj[key].serialize
      end
      new_obj.as_json
    else
      self.map{|i| i.serialize}
    end
  end
end

class ActiveRecord::Relation
  def serialize
    self.map{|i| i.serialize }
  end
end

class Object
  def serialize
    as_json
  end
end
