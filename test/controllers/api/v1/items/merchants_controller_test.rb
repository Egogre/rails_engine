require 'test_helper'

class Api::V1::Items::MerchantsControllerTest < ActionController::TestCase

  test "#show returns item merchant" do
    merchant = nil
    item = nil
    travel_to Time.utc(2004, 11, 24, 01, 04, 44) do
      merchant = Merchant.create(name: "John and Sons")
      item = Item.create(name: "Test Item",
                         description: "Useful",
                         unit_price: 9999,
                         merchant_id: merchant.id)
    end

    expected_merchant = {
      "id" => merchant.id,
      "name" => "John and Sons",
      "created_at" => "2004-11-24T01:04:44.000Z",
      "updated_at" => "2004-11-24T01:04:44.000Z"
    }

    get :show, item_id: item.id, format: :json

    assert_response :success
    assert_equal expected_merchant, response_body
  end

end
