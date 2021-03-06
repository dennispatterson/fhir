module Fhir::Virtus::Serializable
  def serialize
    self.class.attribute_set.each_with_object({}) do |attr, hash|
      hash[attr.name] = serialize_value(self.send(attr.name))
    end.merge(_type: self.class.name)
  end

  private

  def serialize_value(value)
    if value.is_a?(Array)
      serialized_value = value.map { |v| serialize_value(v) }
    elsif value.respond_to?(:independent?) && value.independent?
      nil
    else
      value.respond_to?(:serialize) ? value.serialize : value
    end
  end
end
