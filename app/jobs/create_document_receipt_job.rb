class CreateDocumentReceiptJob < ApplicationJob
  queue_as :default

  def perform(document)
    xml_file = File.open(ActiveStorage::Blob.service.path_for(document.xml.key))
    xml_doc = Nokogiri::XML(xml_file)

    serie  = xml_doc.search("serie").first&.text
    n_nf   = xml_doc.search("nNF").first&.text
    dh_emi = xml_doc.search("dhEmi").first&.text

    receipt = Receipt.new(serie:, dh_emi:, n_nf:)
    receipt.document = document
    receipt.save
  end
end
