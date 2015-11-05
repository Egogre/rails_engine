class Api::V1::Invoices::InvoiceItemsController < Api::BaseController

  def index
    respond_with Invoice.find(params[:invoice_id]).invoice_items
  end

end
