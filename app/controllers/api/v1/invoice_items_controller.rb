class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json

  def index
    respond_with InvoiceItem.all
  end

  def show
    invoice_item = InvoiceItem.find_by(id: params[:id])
    if invoice_item
      respond_with invoice_item
    else
      respond_with invoice_item, status: :not_found
    end
  end

end
