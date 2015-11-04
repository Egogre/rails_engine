require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase

  def invoice
    Invoice.create(customer_id: 1,
                   merchant_id: 1,
                   status: "shipped")
  end

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
    get :show, format: :json, id: invoice.id

    assert_response :success
  end

  test "invoice show gives correct data" do
    get :show, format: :json, id: invoice.id

    assert_equal 1, response_body["customer_id"]
    assert_equal 1, response_body["merchant_id"]
    assert_equal "shipped", response_body["status"]
  end

  test "404 for non-existant invoice" do
    get :show, format: :json, id: invoice.id + 1

    assert_response :not_found
  end

  test "#find invoice" do
    get :find, id: invoice.id, format: :json

    assert_response :success
    assert_equal 1, response_body["customer_id"]
    assert_equal 1, response_body["merchant_id"]
    assert_equal "shipped", response_body["status"]

    get :find, status: "shipped", format: :json

    assert_response :success
    assert_equal 1, response_body["customer_id"]
    assert_equal 1, response_body["merchant_id"]
    assert_equal "shipped", response_body["status"]
  end

  test "#find non-existant invoice" do
    get :find, id: invoice.id + 1, format: :json

    assert_response :not_found
  end

end
