class Api::V1::Invoices::CustomersController < Api::BaseController

  def show
    invoice = Invoice.find(params[:invoice_id])
    respond_with invoice.customer
  end

end
