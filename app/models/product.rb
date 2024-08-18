class Product < ApplicationRecord
  SHOW_PRICE = 10_000_000_000.freeze

  validates :name, :ncm, :cfop, :u_com, :q_com, :v_un_com, presence: true
  belongs_to :document
  has_many :taxes, as: :taxable, dependent: :destroy

  def icms
    taxes.find_by(category: "ICMS")&.value || 0
  end
end
