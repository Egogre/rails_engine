class Api::V1::Customers::TransactionsController < Api::BaseController

  def index
    customer = Customer.find(params[:customer_id])
    respond_with customer.transactions
  end

end
