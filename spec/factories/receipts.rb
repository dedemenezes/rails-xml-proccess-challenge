FactoryBot.define do
  factory :receipt do
    serie { "4" }
    n_nf { "500778" }
    dh_emi { "2024-08-14 20:52:12" }
    document
  end

  factory :receipt_in_the_past, class: 'Receipt' do
    dh_emi { "1969-08-14 20:52:12" }
  end
  factory :receipt_in_the_future, class: 'Receipt' do
    dh_emi { Date.tomorrow.beginning_of_day }
  end
end
