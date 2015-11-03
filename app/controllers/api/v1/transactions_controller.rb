class Api::V1::TransactionsController < Api::BaseController

  def index
    respond_with Transaction.all
  end

  def show
    transaction = Transaction.find_by(id: params[:id])
    if transaction
      respond_with transaction
    else
      respond_with transaction, status: :not_found
    end
  end

end
