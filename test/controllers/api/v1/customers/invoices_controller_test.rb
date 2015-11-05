require 'test_helper'

class Api::V1::Customers::InvoicesControllerTest < ActionController::TestCase

  test "#index returns customer invoices" do
    customer = nil
    invoice1 = nil
    invoice2 = nil
    invoice3 = nil
    travel_to Time.utc(2004, 11, 24, 01, 04, 44) do
      customer = Customer.create(first_name: "John", last_name: "Doe" )
      invoice1 = Invoice.create(customer_id: customer.id,
                                merchant_id: @m1.id,
                                status: "shipped")
      invoice2 = Invoice.create(customer_id: customer.id,
                                merchant_id: @m2.id,
                                status: "shipped")
      invoice3 = Invoice.create(customer_id: customer.id,
                                merchant_id: @m3.id,
                                status: "shipped")
    end
    all_invoices = [
      {
        "id" => invoice1.id,
        "customer_id" => customer.id,
        "merchant_id" => @m1.id,
        "status" => "shipped",
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      },
      {
        "id" => invoice2.id,
        "customer_id" => customer.id,
        "merchant_id" => @m2.id,
        "status" => "shipped",
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      },
      {
        "id" => invoice3.id,
        "customer_id" => customer.id,
        "merchant_id" => @m3.id,
        "status" => "shipped",
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      }
    ]

    get :index, customer_id: customer.id, format: :json

    assert_response :success
    assert_equal all_invoices, response_body
  end

end
