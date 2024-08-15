require 'rails_helper'

RSpec.describe CreateDocumentReceiptJob, type: :job do
  describe '#perform_later' do
    it 'is expected to have enqueued a CreateDocumentReceipt job' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        CreateDocumentReceiptJob.perform_later(create(:document))
      }.to have_enqueued_job
    end

    it "is expected to receive a document as an argument" do
      document = create(:document)
      ActiveJob::Base.queue_adapter = :test
      ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true

      expect(Receipt.count).to eq(0)
      CreateDocumentReceiptJob.perform_later(document)
      expect(CreateDocumentReceiptJob).to(
        have_been_performed.with(document)
      )
      expect(Receipt.count).to eq(1)
    end
  end
end
