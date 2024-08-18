class Tax < ApplicationRecord
  CATEGORIES = [ "ICMS", "COFINS", "IPI", "PIS" ].freeze

  validates :category, inclusion: { in: CATEGORIES }
  validates :value, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :category, uniqueness: { scope: [:taxable_type, :taxable_id] }
  belongs_to :taxable, polymorphic: true
end
