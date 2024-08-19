class Dashboard::DocumentsController < ApplicationController
  def index
    @documents = Document.includes(:receipt, :products).all
    if params[:start_date].present?
      @documents = @documents.joins(:receipt).where('receipts.dh_emi >= ?', Date.parse(params[:start_date]).beginning_of_day)
    end
    if params[:end_date].present?
      @documents = @documents.joins(:receipt).where('receipts.dh_emi <= ?', Date.parse(params[:end_date]).end_of_day)
      Date.parse(params[:end_date])
    end

    if params[:query].present?
      @documents = @documents.global_search(params[:query])
    end
  end

  def show
    @document = Document.find(params[:id])
    @products = @document.products
    if params[:order_by].present?
      @products = @products.sort_by { |prod| prod.taxes.find { |tax| tax.category == params[:order_by] }.value }.reverse
    end
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      CreateDocumentEmiJob.perform_later(@document)
      CreateDocumentDestJob.perform_later(@document)
      CreateDocumentReceiptJob.perform_later(@document)
      CreateDocumentProductsJob.perform_later(@document)
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def document_params
    params.fetch(:document, {}).permit(:xml)
  end
end
