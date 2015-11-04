require 'test_helper'

class Api::V1::InvoiceItems::ItemsControllerTest < ActionController::TestCase

  test "#show returns invoice_item item" do
    invoice_item = nil
    item = nil
    travel_to Time.utc(2004, 11, 24, 01, 04, 44) do
      item = Item.create(name: "Test Item",
                            merchant_id: 1,
                            description: "Useful",
                            unit_price: 9999)
      invoice_item = InvoiceItem.create(item_id: item.id,
                                        invoice_id: 4,
                                        quantity:3,
                                        unit_price:9999)
    end
    expected_item = {
      "id" => item.id,
      "name" => "Test Item",
      "description" => "Useful",
      "unit_price" => 9999,
      "merchant_id" => 1,
      "created_at" => "2004-11-24T01:04:44.000Z",
      "updated_at" => "2004-11-24T01:04:44.000Z"
    }

    get :show, invoice_item_id: invoice_item.id, format: :json

    assert_response :success
    assert_equal expected_item, response_body
  end

end
