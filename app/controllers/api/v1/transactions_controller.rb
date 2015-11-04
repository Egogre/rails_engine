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

  def find
    transaction = Transaction.find_by(find_params)
    if transaction
      respond_with transaction
    else
      respond_with transaction, status: :not_found
    end
  end

  private

  def find_params
    params.permit(:id,
                  :credit_card_number,
                  :invoice_id,
                  :credit_card_expiration_date,
                  :result)
  end

end
