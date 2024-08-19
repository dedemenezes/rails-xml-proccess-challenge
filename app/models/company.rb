class Company < ApplicationRecord
  validates :cnpj, :x_nome, presence: true
  belongs_to :address
end
