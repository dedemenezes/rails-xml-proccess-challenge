class Document < ApplicationRecord
  validates :xml, presence: true
  validate :content_type_must_be_xml

  has_one_attached :xml
  has_one :receipt

  private

  def content_type_must_be_xml
    if xml.present? && !xml.blob.content_type.match?(/xml/)
      errors.add(:xml, "must be XML file format")
    end
  end
end
