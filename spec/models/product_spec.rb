require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:ncm) }
    it { should validate_presence_of(:cfop) }
    it { should validate_presence_of(:u_com) }
    it { should validate_presence_of(:q_com) }
    it { should validate_presence_of(:v_un_com) }
  end

  describe 'Associations' do
    it { should belong_to(:document) }
  end

  describe "#icms" do
    it 'is expected to return icms tax value' do
      product = create(:product)
      expect(product.icms).to eq(0.00)

      create(:sofa_icms, taxable: product)
      expect(product.icms).to eq(330.00)
    end
  end
end
