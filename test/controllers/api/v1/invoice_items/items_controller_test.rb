require 'test_helper'

class Api::V1::InvoiceItems::ItemsControllerTest < ActionController::TestCase

  test "#show returns invoice_item item" do
    invoice_item = nil
    item = nil
    travel_to Time.utc(2004, 11, 24, 01, 04, 44) do
      item = Invoice.create(customer_id: 21,
                               merchant_id: 1,
                               status: "shipped")
      invoice_item = InvoiceItem.create(item_id: 1,
                                        invoice_id: invoice.id,
                                        quantity:3,
                                        unit_price:3333)
    end
    expected_item = {
      "id" => item.id,
      "customer_id" => 21,
      "merchant_id" => 1,
      "status" => "shipped",
      "created_at" => "2004-11-24T01:04:44.000Z",
      "updated_at" => "2004-11-24T01:04:44.000Z"
    }

    get :show, invoice_item_id: invoice_item.id, format: :json

    assert_response :success
    assert_equal expected_invoice, response_body
  end

end
