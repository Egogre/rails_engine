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

end
