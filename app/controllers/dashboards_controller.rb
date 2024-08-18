class DashboardsController < ApplicationController
  def index
    @documents = Document.includes(:receipt, :products).all
  end
end
