require 'rails_helper'

RSpec.describe Document, type: :model do
  describe 'Validations' do
    it { should have_one_attached(:xml) }
    it 'is expected to attach only XML files' do
      document = build(:document_not_xml)
      expect(document.valid?).to be_falsey
      expect(document.errors).to include(:xml)
    end
  end
end
