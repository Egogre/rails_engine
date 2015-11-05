class Api::V1::MerchantsController < Api::BaseController

  def index
    respond_with Merchant.all
  end

  def show
    merchant = Merchant.find_by(id: params[:id])
    if merchant
      respond_with merchant
    else
      respond_with merchant, status: :not_found
    end
  end

  def find
    merchant = Merchant.find_by(find_params)
    if merchant
      respond_with merchant
    else
      respond_with merchant, status: :not_found
    end
  end

  def find_all
    merchants = Merchant.where(find_params)
    if !merchants.empty?
      respond_with merchants
    else
      respond_with merchants, status: :not_found
    end
  end

  def random
    respond_with Merchant.random
  end

  private

  def find_params
    params.permit(:id, :name, :created_at, :updated_at)
  end

end
