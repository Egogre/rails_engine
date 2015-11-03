class Api::V1::CustomersController < Api::BaseController

  def index
    respond_with Customer.all
  end

  def show
    customer = Customer.find_by(id: params[:id])
    if customer
      respond_with customer
    else
      respond_with customer, status: :not_found
    end
  end

  def find
    customer = Customer.find_by(find_params)
    if customer
      respond_with customer
    else
      respond_with customer, status: :not_found
    end
  end



  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name)
  end

  def find_params
    params.permit(:id, :first_name, :last_name)
  end

end
