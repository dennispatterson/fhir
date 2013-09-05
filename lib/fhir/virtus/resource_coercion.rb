module Fhir::Virtus::ResourceCoercion
  def value_coerced?(val)
    klass = val.class
    allowed_types.any? { |t| klass <= t }
  end

  def type_to_coerce(val)
    type = val.fetch(:_type)
    type.constantize
  end

  def coerce_member(value)
    if value.is_a?(::Hash)
      type = value.delete(:_type)

      if type.blank?
	raise ArgumentError, ":_type attribute is required for attribute #{name} #{value.inspect}"
      end

      klass = type.constantize

      check_type!(klass)
      klass.new(value)
    else
      check_type!(value.class)
      value
    end
  end

  protected

  def allowed_types
    @options[:types]
  end

  def check_type!(klass)
    unless allowed_types.any? { |t| klass <= t }
      raise ArgumentError.new("Unexpected type #{klass.name}, expected one of: #{allowed_types.inspect}")
    end
  end
end
