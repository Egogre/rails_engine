class Api::V1::Merchants::InvoicesController < Api::BaseController

  def index
    merchant = Merchant.find(params[:merchant_id])
    respond_with merchant.invoices
  end

end
