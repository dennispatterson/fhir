module Fhir::Virtus
  class Coercer
    def initialize(*types)
      @types = types
    end

    def call(value)
      if value.is_a?(::Hash) && value.key?(:_type)
        type = value.delete(:_type)

        klass = type.constantize

        check_type!(klass, value)
        klass.new(value)
      else
        coerced_value = coerce_according_to_types(value)
        check_type!(coerced_value.class, value)
        coerced_value
      end
    end

    private

    def virtus_coerce(type, value)
      method = "to_#{type.name.downcase}"
      Virtus.coercer[String].public_send(method, value) rescue nil
    end

    def coerce_according_to_types(value)
      result = nil
      return nil if value.nil?

      allowed_types.each do |type|
        result = virtus_coerce(type, value)

        if !result.nil? && result.class <= type
          break
        end
      end

      result
    end

    def allowed_types
      @types
    end

    def check_type!(klass, value)
      if klass != NilClass && !allowed_types.any? { |t| klass <= t }
        raise ArgumentError.new("Unexpected value #{value.inspect} with type #{klass.name}, expected one of: #{allowed_types.inspect}")
      end
    end
  end
end
