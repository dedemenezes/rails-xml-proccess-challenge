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
      sql_subquery = <<~SQL
        products.name ILIKE :query
      SQL
      binding.b
      @documents = @documents.joins(:products).where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def show
    @document = Document.find(params[:id])
  end
end
