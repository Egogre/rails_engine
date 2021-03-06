require 'test_helper'

class Api::V1::Merchants::InvoicesControllerTest < ActionController::TestCase

  test "#index returns merchant invoices" do
    merchant = nil
    invoice1 = nil
    invoice2 = nil
    invoice3 = nil
    travel_to Time.utc(2004, 11, 24, 01, 04, 44) do
      merchant = Merchant.create(name: "John and Sons")
      invoice1 = Invoice.create(customer_id: @c1.id,
                                merchant_id: merchant.id,
                                status: "shipped")
      invoice2 = Invoice.create(customer_id: @c2.id,
                                merchant_id: merchant.id,
                                status: "shipped")
      invoice3 = Invoice.create(customer_id: @c3.id,
                                merchant_id: merchant.id,
                                status: "shipped")
    end
    expected_invoices = [
      {
        "id" => invoice1.id,
        "customer_id" => @c1.id,
        "merchant_id" => merchant.id,
        "status" => "shipped",
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      },
      {
        "id" => invoice2.id,
        "customer_id" => @c2.id,
        "merchant_id" => merchant.id,
        "status" => "shipped",
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      },
      {
        "id" => invoice3.id,
        "customer_id" => @c3.id,
        "merchant_id" => merchant.id,
        "status" => "shipped",
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      }
    ]

    get :index, merchant_id: merchant.id, format: :json

    assert_response :success
    assert_equal expected_invoices, response_body
  end

end
