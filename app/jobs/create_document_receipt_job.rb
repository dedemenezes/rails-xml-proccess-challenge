require 'net/http'

class CreateDocumentReceiptJob < ApplicationJob
  queue_as :default

  def perform(document)
    url = "https://rails-main-dedev-lab.s3.amazonaws.com/#{document.xml.key}"
    uri = URI(url)

    xml_content = Net::HTTP.get(uri)

    xml_doc = Nokogiri::XML(xml_content)

    serie  = xml_doc.search("serie").first&.text
    n_nf   = xml_doc.search("nNF").first&.text
    dh_emi = xml_doc.search("dhEmi").first&.text
    total_value = xml_doc.search("vNF").first&.text.to_f

    receipt = Receipt.new(serie:, dh_emi:, n_nf:, total_value:)
    receipt.document = document
    receipt.save
  end
end
