class Api::V1::InvoicesController < Api::BaseController

  respond_to :json

  def index
    respond_with Invoice.all
  end

  def show
    invoice = Invoice.find_by(id: params[:id])
    if invoice
      respond_with invoice
    else
      respond_with invoice, status: :not_found
    end
  end

  def find
    invoice = Invoice.find_by(find_params)
    if invoice
      respond_with invoice
    else
      respond_with invoice, status: :not_found
    end
  end

  private

  def find_params
    params.permit(:id, :customer_id, :merchant_id, :status)
  end

end
