require 'rails_helper'

RSpec.describe "Dashboard::Documents", type: :request do
  describe "GET /dashboard" do
    it 'should list all documents' do
      create(:document)
      get dashboard_documents_path
      assert_response :success
      assert_select 'h1', 'Documents'
      assert_select '.document-total', "Número de documentos: #{Document.count}"
    end
  end

  describe 'GET /dashboard/documents/:id' do
    it 'should list document details' do
      document = create(:document)
      get dashboard_document_path(document)
      assert_response :success
    end
  end
end
