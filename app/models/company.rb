class Company < ApplicationRecord
  validates :cnpj, :x_nome, presence: true
  belongs_to :address
  has_many :documents_as_sender, class_name: "Document", foreign_key: :sender_id
  has_many :documents_as_receiver, class_name: "Document", foreign_key: :receiver_id
end
