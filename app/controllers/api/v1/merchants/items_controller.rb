class Api::V1::Merchants::ItemsController < Api::BaseController

  def index
    merchant = Merchant.find(params[:merchant_id])
    respond_with merchant.items
  end

end
