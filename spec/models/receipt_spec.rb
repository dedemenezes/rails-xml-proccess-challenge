require 'rails_helper'

RSpec.describe Receipt, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:serie) }
    it { should validate_presence_of(:dh_emi) }
    it { should allow_values('4', '13', '888').for(:serie) }
    it { should_not allow_values('0', '1000', '10000').for(:serie) }
    it 'is expected to validate that :dh_emi cannot be before NF Gov creation' do
      receipt = build(:receipt_in_the_past)
      receipt.valid?
      expect(receipt.errors.messages).to include(:dh_emi)
    end
    it 'is expected to validate that :dh_emi cannot be in the future' do
      receipt = build(:receipt_in_the_future)
      receipt.valid?
      expect(receipt.errors.messages).to include(dh_emi: ["can't be in the future"])
    end
  end

  describe '#emission_date_time' do
    it 'is expected to return human readable date time' do
      receipt = create(:receipt)
      expect(receipt.issue_date).to eq("Wed, 14 Aug 2024 20:52:12")
    end
  end
end
