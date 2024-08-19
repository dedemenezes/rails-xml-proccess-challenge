class Document < ApplicationRecord
  include PgSearch::Model

  validates :xml, presence: true
  validate :content_type_must_be_xml

  has_one_attached :xml
  has_one :receipt, dependent: :destroy
  has_many :products, dependent: :destroy
  belongs_to :sender, class_name: "Company", optional: true
  belongs_to :receiver, class_name: "Company", optional: true

  pg_search_scope :global_search,
    associated_against: {
      products: [ :name ],
      sender: [ :x_nome ],
      receiver: [ :x_nome ]
    },
    using: {
      tsearch: { prefix: true }
    }

  private

  def content_type_must_be_xml
    if xml.present? && !xml.blob.content_type.match?(/xml/)
      errors.add(:xml, "must be XML file format")
    end
  end
end
