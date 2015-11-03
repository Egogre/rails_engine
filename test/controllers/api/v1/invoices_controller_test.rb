require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  test "invoice index json api" do
    get :index, format: :json

    assert_response :success
  end

  test "invoice index count" do
    invoice_count = Invoice.count

    get :index, format: :json

    response_body = JSON.parse(response.body)

    assert_equal invoice_count, response_body.count
  end

  test "invoice show json api" do
    invoice = Invoice.create

    get :show, format: :json, id: invoice.id

    assert_response :success
  end

  test "invoice show gives correct name" do
    invoice = Invoice.create(customer_id: 1,
                             merchant_id: 1,
                             status: "shipped")

    get :show, format: :json, id: invoice.id

    assert_equal 1, response_body["customer_id"]
    assert_equal 1, response_body["merchant_id"]
    assert_equal "shipped", response_body["status"]
  end

  test "404 for non-existant invoice" do
    invoice = Invoice.create(customer_id: 1,
                             merchant_id: 1,
                             status: "shipped")

    get :show, format: :json, id: invoice.id + 1

    assert_response :not_found
  end
end
