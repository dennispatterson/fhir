# A human readable formatted text, including images.
class Fhir::Narrative < Fhir::Type
  # generated | extensions | additional
  # Should be present
  attribute :status, Fhir::Code # code

  # Limited xhtml content
  # Should be present
  attribute :div, String # xhtml
end

