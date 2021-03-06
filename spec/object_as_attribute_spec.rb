require 'spec_helper'

describe 'AllergyIntolerance' do
  example do
    bad_gender = Fhir::Coding.new(system: 'local', code: 'G', display: 'germofrodit')
    pt = Fhir::Patient.new({gender: { coding: [bad_gender] } })
  end
end
