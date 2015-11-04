require 'test_helper'

class Api::V1::Merchants::ItemsControllerTest < ActionController::TestCase

  test "#show returns merchant item" do
    merchant = nil
    item1 = nil
    item2 = nil
    item3 = nil
    travel_to Time.utc(2004, 11, 24, 01, 04, 44) do
      merchant = Merchant.create(name: "John and Sons")
      item1 = Item.create(name: "Test Item",
                            merchant_id: merchant.id,
                            description: "Useful",
                            unit_price: 9999)
      item2 = Item.create(name: "Another Test Item",
                            merchant_id: merchant.id,
                            description: "More Useful",
                            unit_price: 4321)
      item3 = Item.create(name: "Last Test Item",
                            merchant_id: merchant.id,
                            description: "Most Useful",
                            unit_price: 1234)
    end
    expected_items = [
      {
        "id" => item1.id,
        "name" => "Test Item",
        "description" => "Useful",
        "unit_price" => 9999,
        "merchant_id" => merchant.id,
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      },
      {
        "id" => item2.id,
        "name" => "Another Test Item",
        "description" => "More Useful",
        "unit_price" => 4321,
        "merchant_id" => merchant.id,
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      },
      {
        "id" => item3.id,
        "name" => "Last Test Item",
        "description" => "Most Useful",
        "unit_price" => 1234,
        "merchant_id" => merchant.id,
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      }
    ]

    get :index, merchant_id: merchant.id, format: :json

    assert_response :success
    assert_equal expected_items, response_body
  end

end
