require 'test_helper'

class Api::V1::Invoices::CustomersControllerTest < ActionController::TestCase

  test "#show returns invoice customer" do
    customer = nil
    invoice = nil
    travel_to Time.utc(2004, 11, 24, 01, 04, 44) do
      customer = Customer.create(first_name: "John",
                                 last_name: "Doe")
      invoice = Invoice.create(customer_id: customer.id,
                               merchant_id: 1,
                               status: "shipped")
    end
    expected_customer = {
      "id" => customer.id,
      "first_name" => "John",
      "last_name" => "Doe",
      "created_at" => "2004-11-24T01:04:44.000Z",
      "updated_at" => "2004-11-24T01:04:44.000Z"
    }

    get :show, invoice_id: invoice.id, format: :json

    assert_response :success
    assert_equal expected_customer, response_body
  end

end
