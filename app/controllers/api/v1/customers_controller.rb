class Api::V1::CustomersController < ApplicationController
  respond_to :json

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

  def create
    customer = Customer.new(customer_params)
    if customer.save
      respond_with customer, status: :created, location: [:api, :v1, customer]
    else
      respond_with errors: customer.errors, status: :not_acceptable
    end
  end

  def update
    customer = Customer.find(params[:id])
    if customer.update(customer_params)
      respond_with customer, location: [:api, :v1, customer]
    else
      respond_with errors: customer.errors, status: :not_acceptable
    end
  end

  

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name)
  end
end
