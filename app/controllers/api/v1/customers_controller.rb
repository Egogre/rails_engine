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

  def find_all
    customers = Customer.where(find_params)
    if !customers.empty?
      respond_with customers
    else
      respond_with customers, status: :not_found
    end
  end

  def random
    respond_with Customer.random
  end

  private

  def find_params
    params.permit(:id, :first_name, :last_name)
  end

end
