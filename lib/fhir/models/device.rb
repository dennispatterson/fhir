# This resource identifies an instance of a manufactured
# thing that is used in the provision of healthcare without
# being substantially changed through that activity. The
# device may be a machine, an insert, a computer, an
# application, etc. This includes durable (reusable) medical
# equipment as well as disposable equipment used for
# diagnostic, treatment, and research for healthcare and
# public health.
class Fhir::Device < Fhir::Resource
  # What kind of device this is
  # Should be present
  attribute :type, Fhir::CodeableConcept

  # Name of device manufacturer
  attribute :manufacturer, String

  # Model id assigned by the manufacturer
  attribute :model, String

  # Version number (i.e. software)
  attribute :version, String

  # Date of expiry of this device (if applicable)
  attribute :expiry, Date

  # Universal Device Id fields.
  class Identity < Fhir::ValueObject
    # Global Trade Identification Number
    attribute :gtin, String

    # Lot number of manufacture
    attribute :lot, String

    # Serial number assigned by the manufacturer
    # Should be present
    attribute :serial_number, String
  end

  attribute :identity, Identity

  # Organization responsible for device
  resource_reference :owner, [Fhir::Organization]

  # Identifier assigned by various organizations
  attribute :assigned_ids, Array[Fhir::Identifier]

  # Where the resource is found
  resource_reference :location, [Fhir::Location]

  # If the resource is affixed to a person
  resource_reference :patient, [Fhir::Patient]

  # Details for human/organization for support
  attribute :contacts, Array[Fhir::Contact]

  # Network address to contact device
  attribute :url, Fhir::URI
end

