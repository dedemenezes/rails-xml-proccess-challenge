require 'rails_helper'

RSpec.describe CreateDocumentEmiJob, type: :job do
  describe "#perform_later" do
    it "is expected to create emit company for document" do
      expect(Company.count).to eq(0)
      expect(Address.count).to eq(0)
      document = create(:document)
      ActiveJob::Base.queue_adapter = :test
      ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
      CreateDocumentEmiJob.perform_later(document)
      expect(CreateDocumentEmiJob).to(
        have_been_performed.with(document)
      )
      expect(Company.count).to eq(1)
      expect(Address.count).to eq(1)
    end
  end
end
