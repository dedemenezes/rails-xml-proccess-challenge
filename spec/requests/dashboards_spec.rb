require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  describe "GET /dashboard" do
    it 'should list all documents' do
      create(:document)
      get dashboards_path
      assert_select 'h1', 'Documents'
      assert_select '.document-total', "Número de documentos: #{Document.count}"
    end
  end
end
