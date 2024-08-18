require 'rails_helper'

RSpec.describe "Dashboard::Documents", type: :request do
  describe "GET #index" do
    it 'should list all documents' do
      create(:document)
      get dashboard_documents_path
      assert_response :success
      assert_select 'h1', 'Documents'
      assert_select '.document-total', "Número de documentos: #{Document.count}"
    end
  end

  describe 'GET #show' do
    it 'should list document details' do
      product = create(:product)
      get dashboard_document_path(product.document)
      assert_response :success
      assert_select 'h1', "Documento #{product.document.id}"
      assert_select 'td', product.ncm
    end
  end
end
