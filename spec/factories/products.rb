FactoryBot.define do
  factory :product do
    name { "Batata frita" }
    ncm { "02013000" }
    cfop { "6102" }
    u_com { "BALDE" }
    q_com { 100.0000 }
    v_un_com { 250000000000 }
    document
  end
end
