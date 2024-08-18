class CreateDocumentTaxesJob < ApplicationJob
  queue_as :default

  def perform(document)
    xml_file = URI.open("https://rails-main-dedev-lab.s3.amazonaws.com/#{document.xml.key}")

    xml_doc = Nokogiri::XML(xml_file)
    xml_doc.search("det").each do |det|
      taxable = find_product(det)
      next unless taxable

      det.search("imposto").each do |imposto|
        Tax::CATEGORIES.each do |category|
          value = imposto.search("v#{category}").first&.text || 0.0
          tax = Tax.create(value:, taxable:, category:)
        end
      end
    end
  end

  def find_product(element)
    name = element.search("prod xProd").first&.text
    Product.find_by_name(name) # || RAISE ERROR
  end
end
