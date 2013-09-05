# A ratio of two Quantity values - a numerator and a
# denominator.
class Fhir::Ratio < Fhir::DataType
  # The numerator
  attribute :numerator, Fhir::Quantity

  # The denominator
  attribute :denominator, Fhir::Quantity
end

