class Fhir::CodeSystem
  attr_reader :symbolic, :display, :oid, :uris

  DECLARED_SYSTEMS = [{
      symbolic: :unii,
      display: 'UNII',
      oid: '2.16.840.1.113883.4.9'
    }, {
      symbolic: :snomed,
      display: 'SNOMED',
      oid: '2.16.840.1.113883.6.96',
      uri: 'http://snomed.info/id'
    }, {
      symbolic: :loinc,
      display: 'LOINC',
      oid: '2.16.840.1.113883.6.1',
      uri: 'http://loinc.org'
    }, {
      symbolic: :rxnorm,
      display: 'RxNorm',
      oid: '2.16.840.1.113883.6.88'
    }, {
      symbolic: :ucum,
      display: 'The Unified Code for Units of Measure',
      oid: '2.16.840.1.113883.6.8',
      uri: 'http://unitsofmeasure.org'
    }, {
      symbolic: :ndc,
      display: 'NDC',
      oid: '2.16.840.1.113883.6.69'
    }, {
      symbolic: :ndfrt,
      display: 'NDFRT',
      oid: '2.16.840.1.113883.3.26.1.5'
    }, {
      symbolic: :fdb_hic,
      display: 'HIC_SEQN',
      oid: '2.16.840.1.113883.3.84'
    }, {
      symbolic: :fdb_med_name,
      display: 'MED_NAME_ID',
      oid: '2.16.840.1.113883.3.567.12.2'
    }, {
      symbolic: :fdb_allergen_group,
      display: 'DAM_ALRGN_GRP',
      oid: '2.16.840.1.113883.4.296'
    }, {
      symbolic: :fhir_administrative_gender,
      display: 'Gender',
      uri: 'http://hl7.org/fhir/v3/AdministrativeGender'
    }, {
      symbolic: :iso639_2,
      display: 'ISO639-2 Language Names',
      uri: 'http://www.loc.gov/standards/iso639-2'
    }, {
      symbolic: :race,
      display: 'CDC Race code',
      oid: '2.16.840.1.113883.6.238'
    }, {
      symbolic: :null_flavor,
      display: 'HL7 v3 NULL Flavor',
      oid: '2.16.840.1.113883.5.1008',
      uri: 'http://hl7.org/fhir/v3/NullFlavor'
    },
    {
      symbolic: :fhir_condition_category,
      display: 'Fhir Condition Category',
      uri: 'http://hl7.org/fhir/vs/condition-category'
    },
    {
      symbolic: :cpt,
      display: 'Current Procedural Terminology',
      uri: 'http://ama-assn.org/go/cpt'
    },


    # for tests
    {
      symbolic: :rgb,
      display: 'RGB',
      oid: 'RGB'
    }, {
      symbolic: :rgba,
      display: 'RGBA',
      oid: 'RGBA'
    }]

  def initialize(attributes)
    @symbolic = attributes.fetch(:symbolic)
    @display = attributes.fetch(:display)
    @oid = attributes[:oid]

    @uris = [attributes[:uri]]
    @uris << "urn:oid:#{@oid}" if @oid.present?

    @uris = @uris.flatten.uniq.compact
  end

  def uri
    uris.first
  end

  def self.all
    @code_systems ||= DECLARED_SYSTEMS.map do |cs|
      self.new(cs)
    end
  end

  def self.find_by_uri(uri)
    all.find {|cs| cs.uri == uri}
  end

  def self.[](symbolic)
    all.find { |cs| cs.symbolic == symbolic }
  end

  def self.find(oid_or_symbolic_or_uri)
    key = oid_or_symbolic_or_uri

    all.find { |cs| cs.symbolic == key ||
      cs.oid == key ||
      cs.uris.include?(key) }
  end
end
