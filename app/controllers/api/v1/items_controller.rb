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

end
