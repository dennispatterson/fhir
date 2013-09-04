# A value set specifies a set of codes drawn from one or
# more code systems.
class Fhir::ValueSet < Fhir::Resource
  # Logical id to reference this value set
  attribute :identifier, String

  # Logical id for this version of the value set
  attribute :version, String

  # Informal name for this value set
  # Should be present
  attribute :name, String

  # Name of the publisher (Organization or individual)
  attribute :publisher, String

  # Contact information of the publisher
  attribute :telecoms, Array[Fhir::Contact]

  # Human language description of the value set
  # Should be present
  attribute :description, String

  # About the value set or its content
  attribute :copyright, String

  # draft | experimental | review | production | withdrawn |
  # superseded
  # Should be present
  attribute :status, Fhir::Code

  # If for testing purposes, not real usage
  attribute :experimental, Boolean

  # Date for given status
  attribute :date, DateTime

  # When value set defines its own codes.
  class Define < Fhir::ValueObject
    # URI to identify the code system
    # Should be present
    attribute :system, Fhir::URI

    # If code comparison is case sensitive
    attribute :case_sensitive, Boolean

    # Concepts in the code system.
    class Concept < Fhir::ValueObject
      # Code that identifies concept
      # Should be present
      attribute :code, Fhir::Code

      # If this code is not for use as a real concept
      attribute :abstract, Boolean

      # Text to Display to the user
      attribute :display, String

      # Formal Definition
      attribute :definition, String

      # Child Concepts (is-a / contains)
      attribute :concepts, Array[Fhir::ValueSet::Define::Concept]
    end

    attribute :concepts, Array[Concept]
  end

  attribute :define, Define

  # When value set includes codes from elsewhere.
  class Compose < Fhir::ValueObject
    # Import the contents of another value set
    attribute :imports, Array[Fhir::URI]

    # Include one or more codes from a code system.
    class Include < Fhir::ValueObject
      # The system the codes come from
      # Should be present
      attribute :system, Fhir::URI

      # Specific version of the code system referred to
      attribute :version, String

      # Code or concept
      attribute :codes, Array[Fhir::Code]

      # Select concepts by specify a matching criteria based on
      # the properties (including relationships) defined by the
      # system. If multiple filters are specified, they must all be
      # true.
      class Filter < Fhir::ValueObject
        # A property defined by the code system
        # Should be present
        attribute :property, Fhir::Code

        # = | is-a | is_not_a | regex
        # Should be present
        attribute :op, Fhir::Code

        # Code from the system, or regex criteria
        # Should be present
        attribute :value, Fhir::Code
      end

      attribute :filters, Array[Filter]
    end

    attribute :includes, Array[Include]

    # Explicitly exclude codes
    attribute :excludes, Array[Fhir::ValueSet::Compose::Include]
  end

  attribute :compose, Compose

  # When value set is an expansion.
  class Expansion < Fhir::ValueObject
    # Time valueset expansion happened
    # Should be present
    attribute :timestamp, DateTime

    # Codes in the value set.
    class Contains < Fhir::ValueObject
      # System value for the code
      attribute :system, Fhir::URI

      # Code - if blank, this is not a choosable code
      attribute :code, Fhir::Code

      # User display for the concept
      attribute :display, String

      # Codes contained in this concept
      attribute :contains, Array[Fhir::ValueSet::Expansion::Contains]
    end

    attribute :contains, Array[Contains]
  end

  attribute :expansion, Expansion
end

