class Api::V1::Items::MerchantsController < Api::BaseController

  def show
    item = Item.find(params[:item_id])
    respond_with item.merchant
  end

end
