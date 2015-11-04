require 'test_helper'

class Api::V1::Transactions::InvoicesControllerTest < ActionController::TestCase

  test "#show returns transaction invoice" do
    transaction = nil
    invoice = nil
    travel_to Time.utc(2004, 11, 24, 01, 04, 44) do
      invoice = Invoice.create(customer_id: 1,
                               merchant_id: 4,
                               status: "shipped")
      transaction = Transaction.create(invoice_id: 1,
                                       credit_card_number: "1234123412341234",
                                       credit_card_expiration_date: "NEVER!",
                                       result: "Success")
    end
    expected_invoice = {
      "id" => invoice.id,
      "customer_id" => 1,
      "merchant_id" => 4,
      "status" => "shipped",
      "created_at" => "2004-11-24T01:04:44.000Z",
      "updated_at" => "2004-11-24T01:04:44.000Z"
    }

    get :show, transaction_id: transaction.id, format: :json

    assert_response :success
    assert_equal expected_invoice, response_body
  end

end
