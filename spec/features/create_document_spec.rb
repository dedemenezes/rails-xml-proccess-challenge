require 'rails_helper'

RSpec.feature "CreateDocuments", type: :feature do
  describe 'with valid attributes' do
    it 'creates a new document' do
      visit new_document_path
      expect(Document.count).to eq(0)
      attach_file('document_xml', "#{::Rails.root}/spec/factories/data/CASE_001-NFe_004-000500778.xml")
      click_on 'Create Document'
      expect(Document.count).to eq(1)
      expect(Document.last.xml.blob.filename).to eq('CASE_001-NFe_004-000500778.xml')
    end
  end

  describe 'with invalid attributes' do
    it 'render the form with errors' do
      visit new_document_path
      attach_file('document_xml', "#{::Rails.root}/spec/factories/data/document.txt")
      click_on 'Create Document'
      expect(page).to have_text('must be XML file format')
    end
  end
end
