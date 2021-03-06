require 'test_helper'

class Api::V1::Items::InvoiceItemsControllerTest < ActionController::TestCase

  test "#index returns item invoice_items" do
    item = nil
    invoice_item1 = nil
    invoice_item2 = nil
    invoice_item3 = nil
    travel_to Time.utc(2004, 11, 24, 01, 04, 44) do
      item = Item.create(name: "Test Item",
                         merchant_id: @m1.id,
                         description: "Useful",
                         unit_price: 9999)
      invoice_item1 = InvoiceItem.create(item_id: item.id,
                                         invoice_id: @inv2.id,
                                         quantity: 7,
                                         unit_price: 9999)
      invoice_item2 = InvoiceItem.create(item_id: item.id,
                                         invoice_id: @inv5.id,
                                         quantity: 2,
                                         unit_price: 7777)
      invoice_item3 = InvoiceItem.create(item_id: item.id,
                                         invoice_id: @inv19.id,
                                         quantity: 13,
                                         unit_price: 1234)
    end
    expected_invoice_items = [
      {
        "id" => invoice_item1.id,
        "item_id" => item.id,
        "invoice_id" => @inv2.id,
        "quantity" => 7,
        "unit_price" => "99.99",
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      },
      {
        "id" => invoice_item2.id,
        "item_id" => item.id,
        "invoice_id" => @inv5.id,
        "quantity" => 2,
        "unit_price" => "77.77",
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      },
      {
        "id" => invoice_item3.id,
        "item_id" => item.id,
        "invoice_id" => @inv19.id,
        "quantity" => 13,
        "unit_price" => "12.34",
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      }
    ]

    get :index, item_id: item.id, format: :json

    assert_response :success
    assert_equal expected_invoice_items, response_body
  end

end
