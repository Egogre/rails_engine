require 'test_helper'

class Api::V1::Invoices::ItemsControllerTest < ActionController::TestCase

  test "#index returns invoice items" do
    invoice = nil
    invoice_item1 = nil
    invoice_item2 = nil
    invoice_item3 = nil
    item1 = nil
    item2 = nil
    item3 = nil
    travel_to Time.utc(2004, 11, 24, 01, 04, 44) do
      invoice = Invoice.create(customer_id: 1,
                               merchant_id: 1,
                               status: "shipped")
      item1 = Item.create(name: "Test Item",
                          merchant_id: 1,
                          description: "Useful",
                          unit_price: 9999)
      item2 = Item.create(name: "Another Test Item",
                          merchant_id: 1,
                          description: "More Useful",
                          unit_price: 7777)
      item3 = Item.create(name: "Last Test Item",
                          merchant_id: 4,
                          description: "Most Useful",
                          unit_price: 1234)
      invoice_time1 = InvoiceItem.create(item_id: item1.id,
                                         invoice_id: invoice.id,
                                         quantity: 7,
                                         unit_price: 9999)
      invoice_time2 = InvoiceItem.create(item_id: item2.id,
                                         invoice_id: invoice.id,
                                         quantity: 2,
                                         unit_price: 7777)
      invoice_time3 = InvoiceItem.create(item_id: item3.id,
                                         invoice_id: invoice.id,
                                         quantity: 13,
                                         unit_price: 1234)
    end
    expected_items = [
      {
        "id" => item1.id,
        "name" => "Test Item",
        "description" => "Useful",
        "unit_price" => 9999,
        "merchant_id" => 1,
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      },
      {
        "id" => item2.id,
        "name" => "Another Test Item",
        "description" => "More Useful",
        "unit_price" => 7777,
        "merchant_id" => 1,
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      },
      {
        "id" => item3.id,
        "name" => "Last Test Item",
        "description" => "Most Useful",
        "unit_price" => 1234,
        "merchant_id" => 4,
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      }
    ]

    get :index, invoice_id: invoice.id, format: :json

    assert_response :success
    assert_equal expected_items, response_body
  end

end
