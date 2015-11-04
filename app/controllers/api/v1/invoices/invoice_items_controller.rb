class Api::V1::Invoices::InvoiceItemsController < Api::BaseController

  def index
    invoice = Invoice.find(params[:invoice_id])
    respond_with invoice.invoice_items
  end

end
