require 'rails_helper'

RSpec.describe Document, type: :model do
  describe 'Validations' do
    it { should have_one_attached(:xml) }
  end
end
