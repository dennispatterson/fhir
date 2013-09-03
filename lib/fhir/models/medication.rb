# Primarily used for identification and definition of
# Medication, but also covers ingredients and packaging.
class Fhir::Medication < Fhir::Resource
  # Common / Commercial name
  attribute :name, String # string

  # References to std. medication terminologies
  attribute :code, Fhir::CodeableConcept # CodeableConcept

  # True if a brand
  attribute :is_brand, Boolean # boolean

  # Manufacturer of the item
  resource_reference :manufacturer, [Fhir::Organization]

  # product | package
  attribute :kind, Fhir::Code # code

  # If is a product.
  class Product < Fhir::ValueObject
    # Powder | tablets | carton etc
    attribute :form, Fhir::CodeableConcept # CodeableConcept

    # The ingredients of the medication.
    class Ingredient < Fhir::ValueObject
      # Ingredient
      # Should be present
      resource_reference :item, [Fhir::Substance, Fhir::Medication]

      # Amount of ingredient
      attribute :amount, Fhir::Ratio # Ratio
    end

    attribute :ingredients, Array[Ingredient] # 
  end

  attribute :product, Product # 

  # Specifies Ingredient / Product / Package.
  class Package < Fhir::ValueObject
    # Kind of container
    attribute :container, Fhir::CodeableConcept # CodeableConcept

    # A set of components that go to make up the described item.
    class Content < Fhir::ValueObject
      # A product in the package
      # Should be present
      resource_reference :item, [Fhir::Medication]

      # Amount in the package
      attribute :amount, Fhir::Quantity # Quantity
    end

    attribute :contents, Array[Content] # 
  end

  attribute :package, Package # 
end

