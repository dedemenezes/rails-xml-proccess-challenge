class Document < ApplicationRecord
  validates :xml, presence: true
  has_one_attached :xml
  validate :content_type_must_be_xml

  private

  def content_type_must_be_xml
    if xml.present? && !xml.blob.content_type.match?(/xml/)
      errors.add(:xml, "must be XML file format")
    end
  end
end
