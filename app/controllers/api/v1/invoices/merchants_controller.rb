class Api::V1::Invoices::MerchantsController < Api::BaseController

  def show
    invoice = Invoice.find(params[:invoice_id])
    respond_with invoice.merchant
  end

end
