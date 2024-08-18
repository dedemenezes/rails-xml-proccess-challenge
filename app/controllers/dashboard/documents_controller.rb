class Dashboard::DocumentsController < ApplicationController
  def index
    @documents = Document.includes(:receipt, :products).all
  end

  def show
    @document = Document.find(params[:id])
  end
end
