require 'rails_helper'

RSpec.describe CreateDocumentProductsJob, type: :job do
  describe `#perform_later` do
    it "is expected to receive a document as an argument" do
      document = create(:document)
      ActiveJob::Base.queue_adapter = :test
      ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true

      expect(Product.count).to eq(0)
      CreateDocumentProductsJob.perform_later(document)
      expect(CreateDocumentProductsJob).to(
        have_been_performed.with(document)
      )
      expect(Product.count).to eq(2)
    end
  end
end
