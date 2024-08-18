class CreateDocumentReceiptJob < ApplicationJob
  queue_as :default

  def perform(document)
    xml_file = URI.open("https://rails-main-dedev-lab.s3.amazonaws.com/#{document.xml.key}")
    # Rails.application.routes.url_helpers.rails_blob_url(attachment, only_path: false)
    xml_doc = Nokogiri::XML(xml_file)

    serie  = xml_doc.search("serie").first&.text
    n_nf   = xml_doc.search("nNF").first&.text
    dh_emi = xml_doc.search("dhEmi").first&.text
    total_value = xml_doc.search("vNF").first&.text.to_f
    binding.b

    receipt = Receipt.new(serie:, dh_emi:, n_nf:, total_value:)
    receipt.document = document
    receipt.save
  end
end
