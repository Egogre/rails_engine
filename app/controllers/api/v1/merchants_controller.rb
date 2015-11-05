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

  def most_revenue
    respond_with Merchant.most_revenue(params[:quantity])
  end

  def most_items
    respond_with Merchant.most_items(params[:quantity])
  end

  def revenue
    respond_with Merchant.revenue(params[:date])
  end

  private

  def find_params
    params.permit(:id, :name)
  end

end
