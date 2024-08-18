require 'rails_helper'

RSpec.describe Tax, type: :model do
  before do
    create(:sofa_icms)
  end

  describe "Validations" do
    it { should validate_presence_of(:value) }
    it { should validate_numericality_of(:value).is_greater_than_or_equal_to(0.0) }
    it { should validate_uniqueness_of(:category).scoped_to([:taxable_type, :taxable_id]) }
    it { should validate_inclusion_of(:category).in_array([ "ICMS", "COFINS", "IPI", "PIS" ]) }
  end

end
