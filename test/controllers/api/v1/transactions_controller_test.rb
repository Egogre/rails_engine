require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase

  test "transaction index json api" do
    get :index, format: :json

    assert_response :success
  end

  test "transaction index count" do
    transaction_count = Transaction.count

    get :index, format: :json

    assert_equal transaction_count, response_body.count
  end

  test "transaction show json api" do
    transaction = Transaction.create

    get :show, format: :json, id: transaction.id

    assert_response :success
  end

  test "transaction show gives correct data" do
    transaction = Transaction.create(invoice_id: 1,
                                     credit_card_number: "1234123412341234",
                                     credit_card_expiration_date: "NEVER!",
                                     result: "Success")

    get :show, format: :json, id: transaction.id

    assert_equal 1, response_body["invoice_id"]
    assert_equal "1234123412341234", response_body["credit_card_number"]
    assert_equal "NEVER!", response_body["credit_card_expiration_date"]
    assert_equal "Success", response_body["result"]
  end

  test "404 for non-existant transaction" do
    transaction = Transaction.create(invoice_id: 1,
                                     credit_card_number: "1234123412341234",
                                     credit_card_expiration_date: "NEVER!",
                                     result: "Success")

    get :show, format: :json, id: transaction.id + 1

    assert_response :not_found
  end

end
