class Address < ApplicationRecord
  validates :logradouro, :numero, :bairro, :x_municipio, :c_municipio, :uf, :cep, :c_pais, :x_pais, presence: true
  has_one :company
end
