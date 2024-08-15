class Receipt < ApplicationRecord
  validates :dh_emi, :serie, presence: true
  validates :serie, length: { maximum: 3 }, exclusion: { in: %w[0] }
  validates_with AfterNFWasCreated
  validates_with DHCannotBeInTheFuture

  before_validation :fill_n_nf_with_zeros

  private

  def fill_n_nf_with_zeros
    return unless n_nf
    self.n_nf = "#{('0' * (9 - n_nf.size))}#{n_nf}"
  end
end
