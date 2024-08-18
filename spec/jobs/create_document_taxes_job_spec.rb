require 'rails_helper'

RSpec.describe CreateDocumentTaxesJob, type: :job do
  describe "#perform_later" do
    it "is expected to create taxes for products" do
      create(:product)
      document = create(:document)
      ActiveJob::Base.queue_adapter = :test
      ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
      CreateDocumentTaxesJob.perform_later(document)
      expect(CreateDocumentTaxesJob).to(
        have_been_performed.with(document)
      )
      expect(Tax.count).to eq(4)
    end
  end
end
