class CreateDocumentEmiJob < ApplicationJob
  queue_as :default
  def perform(document)
    url = "https://rails-main-dedev-lab.s3.amazonaws.com/#{document.xml.key}"
    uri = URI(url)

    xml_content = Net::HTTP.get(uri)

    xml_doc = Nokogiri::XML(xml_content)

    emits = xml_doc.search("emit enderEmit").map do |ender_emit|
      {
        logradouro: ender_emit.search("xLgr").first.text,
        numero: ender_emit.search("nro").first.text,
        complemento: ender_emit.search("xCpl").first.text,
        bairro: ender_emit.search("xBairro").first.text,
        c_municipio: ender_emit.search("cMun").first.text,
        x_municipio: ender_emit.search("xMun").first.text,
        uf: ender_emit.search("UF").first.text,
        cep: ender_emit.search("CEP").first.text,
        c_pais: ender_emit.search("cPais").first.text,
        x_pais: ender_emit.search("xPais").first.text,
        fone: ender_emit.search("fone").first.text
      }
    end
    return if emits.empty?

    address = Address.find_or_create_by(emits.first)

    comp = {
      cnpj: xml_doc.search("emit CNPJ").first&.text,
      x_nome: xml_doc.search("emit xNome").first&.text,
      x_fant: xml_doc.search("emit xFant").first&.text,
      ie: xml_doc.search("emit IE").first&.text,
      crt: xml_doc.search("emit CRT").first&.text,
      address: address
    }

    company = Company.find_or_create_by!(comp)
  end
end
