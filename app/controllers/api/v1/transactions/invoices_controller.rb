class Api::V1::Transactions::InvoicesController < Api::BaseController

  def show
    transaction = Transaction.find(params[:transaction_id])
    respond_with transaction.invoice
  end

end
