class Receipt < ApplicationRecord
  validates :n_nf, :dh_emi, :serie, presence: true
  validates :n_nf, length: { is: 9 }
  validates :serie, length: { maximum: 3 }, exclusion: { in: %w[0] }
  validates_with AfterNFWasCreated
  validates_with DHCannotBeInTheFuture
end
