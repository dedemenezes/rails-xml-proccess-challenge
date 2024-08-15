class Document < ApplicationRecord
  has_one_attached :xml
  validate :content_type_must_be_xml

  private

  def content_type_must_be_xml
    if nf.present? && !nf.blob.content_type.match?(/xml/)
      errors.add(:nf, "must be XML file format")
    end
  end
end
