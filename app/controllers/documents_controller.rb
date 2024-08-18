class DocumentsController < ApplicationController
  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      CreateDocumentReceiptJob.perform_later(@document)
      CreateDocumentProductsJob.perform_later(@document)
      redirect_to dashboard_documents_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def document_params
    params.fetch(:document, {}).permit(:xml)
  end
end
