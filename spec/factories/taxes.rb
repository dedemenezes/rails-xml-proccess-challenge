FactoryBot.define do
  factory :sofa_icms, class: 'Tax' do
    category { "ICMS" }
    value { 0.25 }
    taxable_type { "Product" }
    taxable_id { create(:product).id }
  end
end
