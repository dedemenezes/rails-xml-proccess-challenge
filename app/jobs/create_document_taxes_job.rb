class CreateDocumentTaxesJob < ApplicationJob
  queue_as :default

  def perform(document)
    # Do something later
    # 1. Pegar o documento
    xml_file = File.open(ActiveStorage::Blob.service.path_for(document.xml.key))
    xml_doc = Nokogiri::XML(xml_file)
    xml_doc.search("det").each do |det|

      taxable = find_product(det)
      det.search("imposto").each do |imposto|
        Tax::CATEGORIES.each do |category|
          value = imposto.search("v#{category}").first&.text || 0.0
          tax = Tax.create(value:, taxable:, category:)
        end
      end
    end

    # 2. Atribuir taxas ao recibo
    # puts "!!!!!!!!!!!!TAXES CREATED!!!!!!!!!!!!"
    # xml_doc.search('total').each do |total|
    #   icms_total = total.search('vICMS').first.text.to_f
    #   product_icms_total = document.products.map { |product| product.taxes.find_by(category: 'ICMS').value }.sum
    #   puts icms_total === product_icms_total
    # end
    # 3. idetificar os produtos e atribuir impostos
  end

  def find_product(element)
    name = element.search("prod xProd").first&.text
    Product.find_by_name(name)
  end
end
