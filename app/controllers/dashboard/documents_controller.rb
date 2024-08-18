class Dashboard::DocumentsController < ApplicationController
  def index
    @documents = Document.includes(:receipt, :products).all
  end

  def show
    binding.b
  end
end
