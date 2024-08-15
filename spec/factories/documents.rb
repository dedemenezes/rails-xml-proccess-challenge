FactoryBot.define do
  factory :document do

    after(:build) do |document|
      document.xml.attach(
        io: File.open(Rails.root.join('spec', 'factories', 'data', 'CASE_001-NFe_004-000500778.xml')),
        filename: 'CASE_001-NFe_004-000500778.xml',
        content_type: 'xml'
      )
    end
  end
  factory :document_not_xml, class: 'Document' do

    after(:build) do |document|
      document.xml.attach(
        io: File.open(Rails.root.join('spec', 'factories', 'data', 'document.txt')),
        filename: 'test_document.txt',
        content_type: 'txt'
      )
    end
  end
end
