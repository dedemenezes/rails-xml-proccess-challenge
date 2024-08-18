class CreateDocumentProductsJob < ApplicationJob
  class InvalidXMLError < StandardError; end

  queue_as :default

  def perform(document)
    xml_file = File.open(ActiveStorage::Blob.service.path_for(document.xml.key))
    xml_doc = Nokogiri::XML(xml_file)

    products = xml_doc.search("det").map do |e|
      {
        name: find_by_tag(e, "prod xProd"),
        ncm: find_by_tag(e, "prod NCM"),
        cfop: find_by_tag(e, "prod CFOP"),
        u_com: find_by_tag(e, "prod uCom"),
        q_com: find_by_tag(e, "prod qCom"),
        v_un_com: find_by_tag(e, "prod vUnCom").to_f,
        v_icms: find_by_tag(e, "imposto vICMS").to_f,
        document: document
      }
    end
    product_collection = products.map do |attributes|
      Product.find_or_create_by(attributes)
    end

    CreateDocumentTaxesJob.perform_later(document)
  end

  def find_by_tag(element, name)
    result = element.search("#{name}").first
    if result
      result.text
    else
      raise InvalidXMLError, "Tag <#{name}> not found"
    end
  end
end
