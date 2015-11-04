class Api::V1::InvoiceItemsController < Api::BaseController

  def index
    respond_with InvoiceItem.all
  end

  def show
    invoice_item = InvoiceItem.find_by(id: params[:id])
    if invoice_item
      respond_with invoice_item
    else
      respond_with invoice_item, status: :not_found
    end
  end

  def find
    invoice_item = InvoiceItem.find_by(find_params)
    if invoice_item
      respond_with invoice_item
    else
      respond_with invoice_item, status: :not_found
    end
  end

  def find_all
    invoice_items = InvoiceItem.where(find_params)
    if !invoice_items.empty?
      respond_with invoice_items
    else
      respond_with invoice_items, status: :not_found
    end
  end

  def random
    respond_with InvoiceItem.random
  end

  private

  def find_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price)
  end

end
