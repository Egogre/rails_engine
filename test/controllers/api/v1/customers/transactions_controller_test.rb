require 'test_helper'

class Api::V1::Customers::TransactionsControllerTest < ActionController::TestCase

  test "#index returns customer transactions" do
    customer = nil
    transaction1 = nil
    transaction2 = nil
    transaction3 = nil
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
      transaction1 = Transaction.create(invoice_id: invoice1.id,
                                        credit_card_number: "1234123412341234",
                                        credit_card_expiration_date: "NEVER!",
                                        result: "Success")
      transaction2 = Transaction.create(invoice_id: invoice2.id,
                                        credit_card_number: "4321432143214321",
                                        credit_card_expiration_date: "SOON!",
                                        result: "Success")
      transaction3 = Transaction.create(invoice_id: invoice3.id,
                                        credit_card_number: "0987098709870987",
                                        credit_card_expiration_date: "NOW!",
                                        result: "Failed")
    end
    expected_transactions = [
      {
        "id" => transaction1.id,
        "invoice_id" => invoice1.id,
        "credit_card_number" => "1234123412341234",
        "credit_card_expiration_date" => "NEVER!",
        "result" => "Success",
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      },
      {
        "id" => transaction2.id,
        "invoice_id" => invoice2.id,
        "credit_card_number" => "4321432143214321",
        "credit_card_expiration_date" => "SOON!",
        "result" => "Success",
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      },
      {
        "id" => transaction3.id,
        "invoice_id" => invoice3.id,
        "credit_card_number" => "0987098709870987",
        "credit_card_expiration_date" => "NOW!",
        "result" => "Failed",
        "created_at" => "2004-11-24T01:04:44.000Z",
        "updated_at" => "2004-11-24T01:04:44.000Z"
      }
    ]

    get :index, customer_id: customer.id, format: :json

    assert_response :success
    assert_equal expected_transactions, response_body
  end

end
