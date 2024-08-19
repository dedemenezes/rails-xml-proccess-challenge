class CreateDocumentDestJob < ApplicationJob
  queue_as :default

  def perform(document)
    url = "https://rails-main-dedev-lab.s3.amazonaws.com/#{document.xml.key}"
    uri = URI(url)

    xml_content = Net::HTTP.get(uri)

    xml_doc = Nokogiri::XML(xml_content)

    dests = xml_doc.search("dest enderDest").map do |ender_dest|
      {
        logradouro: ender_dest.search("xLgr").first.text,
        numero: ender_dest.search("nro").first.text,
        bairro: ender_dest.search("xBairro").first.text,
        c_municipio: ender_dest.search("cMun").first.text,
        x_municipio: ender_dest.search("xMun").first.text,
        uf: ender_dest.search("UF").first.text,
        cep: ender_dest.search("CEP").first.text,
        c_pais: ender_dest.search("cPais").first.text,
        x_pais: ender_dest.search("xPais").first.text
      }
    end
    return if dests.empty?

    address = Address.find_or_create_by(dests.first)

    comp = {
      cnpj: xml_doc.search("dest CNPJ").first&.text,
      x_nome: xml_doc.search("dest xNome").first&.text,
      ie_dest: xml_doc.search("dest indIEDest").first&.text,
      address: address
    }

    company = Company.find_or_create_by!(comp)
  end
end
