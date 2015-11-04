class Api::V1::Invoices::ItemsController < Api::BaseController

  def index
    invoice = Invoice.find(params[:invoice_id])
    respond_with invoice.items
  end

end
