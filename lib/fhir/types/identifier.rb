# A technical identifier - identifies some entity uniquely
# and unambiguously.
class Fhir::Identifier < Fhir::Type
  # The use of this identifier
  attribute :use, Fhir::Code

  # Description of identifier
  attribute :label, String

  # The namespace for the identifier
  attribute :system, Fhir::URI

  # The value that is unique
  attribute :key, String

  # Time period when id was valid for use
  attribute :period, Fhir::Period

  # Organization that issued id (may be just text)
  resource_reference :assigner, [Fhir::Organization]
end

