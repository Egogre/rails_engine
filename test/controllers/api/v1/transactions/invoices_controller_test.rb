require 'test_helper'

class Api::V1::Transactions::InvoicesControllerTest < ActionController::TestCase

  test "#show returns transaction invoice" do
    transaction = nil
    invoice = nil
    travel_to Time.utc(2004, 11, 24, 01, 04, 44) do
      invoice = Invoice.create(customer_id: @c1.id,
                               merchant_id: @m4.id,
                               status: "shipped")
      transaction = Transaction.create(invoice_id: @inv1.id,
                                       credit_card_number: "1234123412341234",
                                       credit_card_expiration_date: "NEVER!",
                                       result: "Success")
    end
    expected_invoice = {
      "id" => @inv1.id,
      "customer_id" => @c1.id,
      "merchant_id" => @m1.id,
      "status" => "shipped",
      "created_at" => "2004-11-24T01:04:44.000Z",
      "updated_at" => "2004-11-24T01:04:44.000Z"
    }

    get :show, transaction_id: transaction.id, format: :json

    assert_response :success
    assert_equal expected_invoice, response_body
  end

end
