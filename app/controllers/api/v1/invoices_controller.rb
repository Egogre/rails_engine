class Api::V1::InvoicesController < ApplicationController

  respond_to :json

  def index
    respond_with Invoice.all
  end

  def show
    invoice = Invoice.find_by(id: params[:id])
    if invoice
      respond_with invoice
    else
      respond_with invoice, status: :not_found
    end
  end

end
