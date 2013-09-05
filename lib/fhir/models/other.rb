# Other is a conformant for handling resource concepts not
# yet defined for FHIR or outside HL7's scope of interest.
class Fhir::Other < Fhir::Resource
  invariants do
    validates_presence_of :code
  end

  # Kind of Resource
  # Should be present
  attribute :code, Fhir::CodeableConcept

  # Identifies the
  resource_reference :subject, [Fhir::Resource]

  # Who created
  resource_reference :author, [Fhir::Practitioner, Fhir::Patient, Fhir::RelatedPerson]

  # When created
  attribute :created, Date
end

