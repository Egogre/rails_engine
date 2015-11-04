require 'test_helper'

class Api::V1::Invoices::MerchantsControllerTest < ActionController::TestCase

  test "#show returns invoice merchant" do
    merchant = nil
    invoice = nil
    travel_to Time.utc(2004, 11, 24, 01, 04, 44) do
      merchant = Merchant.create(name: "John and Sons")
      invoice = Invoice.create(customer_id: 1,
                               merchant_id: merchant.id,
                               status: "shipped")
    end
    expected_merchant = {
      "id" => merchant.id,
      "name" => "John and Sons",
      "created_at" => "2004-11-24T01:04:44.000Z",
      "updated_at" => "2004-11-24T01:04:44.000Z"
    }

    get :show, invoice_id: invoice.id, format: :json

    assert_response :success
    assert_equal expected_merchant, response_body
  end

end
