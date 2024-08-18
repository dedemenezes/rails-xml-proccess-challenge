class Receipt < ApplicationRecord
  validates :dh_emi, :serie, presence: true
  validates :serie, length: { maximum: 3 }, exclusion: { in: %w[0] }
  validates_with AfterNFWasCreated
  validates_with DHCannotBeInTheFuture

  before_validation :fill_n_nf_with_zeros
  belongs_to :document

  def issue_date
    dh_emi.strftime("%a, %d %b %Y %H:%M:%S")
  end

  private

  def fill_n_nf_with_zeros
    return unless n_nf
    self.n_nf = "#{('0' * (9 - n_nf.size))}#{n_nf}"
  end
end
