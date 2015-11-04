require 'test_helper'

class Api::V1::Invoices::TransactionsControllerTest < ActionController::TestCase

  test "#index returns invoice transactions" do
    invoice = nil
    transaction1 = nil
    transaction2 = nil
    transaction3 = nil
    travel_to Time.utc(2004, 11, 24, 01, 04, 44) do
      invoice = Invoice.create(customer_id: 1,
                               merchant_id: 1,
                               status: "shipped")
      transaction1 = Transaction.create(invoice_id: invoice.id,
                                        credit_card_number: "1234123412341234",
                                        credit_card_expiration_date: "NEVER!",
                                        result: "failed")
      transaction2 = Transaction.create(invoice_id: invoice.id,
                                        credit_card_number: "4321432143214321",
                                        credit_card_expiration_date: "SOON!",
                                        result: "failed")
      transaction3 = Transaction.create(invoice_id: invoice.id,
                                        credit_card_number: "0987098709870987",
                                        credit_card_expiration_date: "NOW!",
                                        result: "success")
    end
    expected_transactions = [
      {
        "id" => transaction1.id,
        "invoice_id" => invoice.id,
        "credit_card_number" => "1234123412341234",
        "credit_card_expiration_date" => "NEVER!",
        "result" => "failed",
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      },
      {
        "id" => transaction2.id,
        "invoice_id" => invoice.id,
        "credit_card_number" => "4321432143214321",
        "credit_card_expiration_date" => "SOON!",
        "result" => "failed",
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      },
      {
        "id" => transaction3.id,
        "invoice_id" => invoice.id,
        "credit_card_number" => "0987098709870987",
        "credit_card_expiration_date" => "NOW!",
        "result" => "success",
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      }
    ]

    get :index, invoice_id: invoice.id, format: :json

    assert_response :success
    assert_equal expected_transactions, response_body
  end

end
