class Product < ApplicationRecord
  validates :name, :ncm, :cfop, :u_com, :q_com, :v_un_com, presence: true
  belongs_to :document
end
