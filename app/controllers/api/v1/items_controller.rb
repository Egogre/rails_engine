class Api::V1::ItemsController < Api::BaseController

  def index
    respond_with Item.all
  end

  def show
    item = Item.find_by(id: params[:id])
    if item
      respond_with item
    else
      respond_with item, status: :not_found
    end
  end

  def find
    item = Item.find_by(find_params)
    if item
      respond_with item
    else
      respond_with item, status: :not_found
    end
  end

  private

  def find_params
    params.permit(:id, :name, :description, :merchant_id, :unit_price)
  end

end
