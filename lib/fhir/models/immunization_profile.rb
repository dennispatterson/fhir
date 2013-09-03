# A patient's point-of-time immunization status and
# recommendation with optional supporting justification.
class Fhir::ImmunizationProfile < Fhir::Resource
  # Who this profile is for
  # Should be present
  resource_reference :subject, [Fhir::Patient]

  # Vaccine administration recommendations.
  class Recommendation < Fhir::ValueObject
    # Recommendation date
    # Should be present
    attribute :recommendation_date, DateTime # dateTime

    # Vaccine that pertains to the recommendation
    # Should be present
    attribute :vaccine_type, Fhir::CodeableConcept # CodeableConcept

    # Recommended dose number
    attribute :dose_number, Integer # integer

    # Vaccine administration status
    # Should be present
    attribute :forecast_status, Fhir::Code # code

    # Vaccine date recommentations - e.g. earliest date to
    # administer, latest date to administer, etc.
    class DateCriterion < Fhir::ValueObject
      # Date classification of recommendation
      # Should be present
      attribute :code, Fhir::CodeableConcept # CodeableConcept

      # Date recommendation
      # Should be present
      attribute :value, DateTime # dateTime
    end

    attribute :date_criterions, Array[DateCriterion] # 

    # Contains information about the protocol under which the
    # vaccine was administered.
    class Protocol < Fhir::ValueObject
      # Dose Number
      attribute :dose_sequence, Integer # integer

      # Vaccine Administration Protocol Description
      attribute :description, String # string

      # Vaccine Administration Protocol Authority
      resource_reference :authority, [Fhir::Organization]

      # Vaccine Series
      attribute :series, String # string
    end

    attribute :protocol, Protocol # 

    # Supporting Immunization
    resource_references :supporting_immunizations, [Fhir::Immunization]

    # Adverse event report information that supports the status
    # and recommendation.
    class SupportingAdverseEventReport < Fhir::ValueObject
      # Adverse event report identifier
      # Should be present
      attribute :identifiers, Array[String] # id

      # Adverse event report classification
      attribute :report_type, Fhir::CodeableConcept # CodeableConcept

      # Adverse event report date
      attribute :report_date, DateTime # dateTime

      # Documented reaction
      resource_references :reactions, [Fhir::AdverseReaction]
    end

    attribute :supporting_adverse_event_reports, Array[SupportingAdverseEventReport] # 

    # Supporting Patient Observation
    resource_references :supporting_patient_observations, [Fhir::Observation]
  end

  # Should be present
  attribute :recommendations, Array[Recommendation] # 
end

