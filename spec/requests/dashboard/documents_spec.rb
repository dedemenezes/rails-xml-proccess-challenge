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
      p_icms = create(:sofa_icms)
      get dashboard_document_path(p_icms.taxable.document)
      assert_response :success
      assert_select 'h1', "Documento #{p_icms.taxable.document.id}"
      assert_select 'td', p_icms.taxable.ncm
      assert_select "td#tax_#{p_icms.id}", "0.25"
    end
  end
end
