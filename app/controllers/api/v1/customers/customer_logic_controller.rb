class Api::V1::Customers::CustomerLogicController < Api::BaseController

  def favorite_merchant
    respond_with Merchant.favorite_merchant(params[:id]).first
  end
end
