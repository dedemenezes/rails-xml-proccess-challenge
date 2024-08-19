require 'rails_helper'

RSpec.describe CreateDocumentDestJob, type: :job do
  describe "#perform_later" do
    it "is expected to create dest company for document" do
      expect(Company.count).to eq(0)
      expect(Address.count).to eq(0)
      document = create(:document)
      ActiveJob::Base.queue_adapter = :test
      ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
      CreateDocumentDestJob.perform_later(document)
      expect(CreateDocumentDestJob).to(
        have_been_performed.with(document)
      )
      expect(Company.count).to eq(1)
      expect(Address.count).to eq(1)
    end
  end
end
