class Api::V1::Invoices::TransactionsController < Api::BaseController

  def index
    invoice = Invoice.find(params[:invoice_id])
    respond_with invoice.transactions
  end

end
