class CreateDocumentReceiptJob < ApplicationJob
  queue_as :default

  def perform(document)
    xml_file = File.open(ActiveStorage::Blob.service.path_for(document.xml.key))
    document = Nokogiri::XML(xml_file)

    serie  = document.search("serie").first&.text
    n_nf   = document.search("nNF").first&.text
    dh_emi = document.search("dhEmi").first&.text

    receipt = Receipt.new(serie:, dh_emi:, n_nf:)
    receipt.save
  end
end
