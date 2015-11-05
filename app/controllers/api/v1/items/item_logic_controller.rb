class Api::V1::Items::ItemLogicController < Api::BaseController

  def most_revenue
    respond_with Item.most_revenue(params[:quantity])
  end

  def most_items
    respond_with Item.most_items(params[:quantity])
  end

  def best_day
    respond_with({"best_day" => Item.best_day(params[:id])})
  end
end
