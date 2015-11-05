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
    find_params[:unit_price].gsub!(".", "") if find_params[:unit_price]
    item = Item.find_by(find_params)
    if item
      respond_with item
    else
      respond_with item, status: :not_found
    end
  end

  def find_all
    find_params[:unit_price].gsub!(".", "") if find_params[:unit_price]
    items = Item.where(find_params)
    if !items.empty?
      respond_with items
    else
      respond_with items, status: :not_found
    end
  end

  def random
    respond_with Item.random
  end

  private

  def find_params
    params.permit(:id, :name, :description, :merchant_id, :unit_price, :created_at, :updated_at)
  end

end
