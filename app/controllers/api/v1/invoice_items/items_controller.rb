class Api::V1::InvoiceItems::ItemsController < Api::BaseController

  def show
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    respond_with invoice_item.item
  end

end
