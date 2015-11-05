require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase

  def transaction
    Transaction.create(invoice_id: @inv1.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "Success")
  end

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
    get :show, format: :json, id: transaction.id

    assert_response :success
  end

  test "transaction show gives correct data" do
    get :show, format: :json, id: transaction.id

    assert_equal 1, response_body["invoice_id"]
    assert_equal "1234123412341234", response_body["credit_card_number"]
    assert_equal "NEVER!", response_body["credit_card_expiration_date"]
    assert_equal "Success", response_body["result"]
  end

  test "404 for non-existant transaction" do
    get :show, format: :json, id: transaction.id + 1

    assert_response :not_found
  end

  test "#find transaction" do
    get :find, id: transaction.id, format: :json

    assert_response :success
    assert_equal "1234123412341234", response_body["credit_card_number"]

    get :find, credit_card_number: 1234123412341234, format: :json

    assert_response :success
    assert_equal "NEVER!", response_body["credit_card_expiration_date"]
  end

  test "#find non-existant transaction" do
    get :find, id: transaction.id + 1, format: :json

    assert_response :not_found
  end

  test "#find_all transactions" do
    Transaction.create(invoice_id: @inv11.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "Success",
                       created_at: "2012-03-27T14:54:57.000Z")
    Transaction.create(invoice_id: @inv1.id,
                       credit_card_number: "4321432143214321",
                       credit_card_expiration_date: "SOON!",
                       result: "Success",
                       created_at: "2012-03-27T14:54:57.000Z")

    get :find_all, created_at: "2012-03-27T14:54:57.000Z", format: :json

    assert_response :success
    assert_equal 2, response_body.count
    assert_equal "NEVER!", response_body[0]["credit_card_expiration_date"]
  end

  test "#find_all with no transaction matches" do
    Transaction.create(invoice_id: @inv1.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "Success")
    Transaction.create(invoice_id: @inv1.id,
                       credit_card_number: "4321432143214321",
                       credit_card_expiration_date: "SOON!",
                       result: "Success")

    get :find_all, invoice_id: 55544, format: :json

    assert_response :not_found
  end

  test "#random transaction" do
    Transaction.create(invoice_id: @inv1.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "Success")
    Transaction.create(invoice_id: @inv2.id,
                       credit_card_number: "4321432143214321",
                       credit_card_expiration_date: "SOON!",
                       result: "Success")
    Transaction.create(invoice_id: @inv4.id,
                       credit_card_number: "3456345634563456",
                       credit_card_expiration_date: "NOW!",
                       result: "Success")
    Transaction.create(invoice_id: @inv5.id,
                       credit_card_number: "6543654365436543",
                       credit_card_expiration_date: "YESTERDAY!",
                       result: "Success")

    get :random, format: :json

    assert_response :success
    assert_includes ["NEVER!", "SOON!", "NOW!", "YESTERDAY!"], response_body["credit_card_expiration_date"]
  end

end
