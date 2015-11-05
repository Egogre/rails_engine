require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase

  def invoice
    Invoice.create(customer_id: @c1.id,
                   merchant_id: @m1.id,
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

  test "#find_all invoices" do
    Invoice.create(customer_id: @c1.id,
                   merchant_id: @m4.id,
                   status: "shipped")
    Invoice.create(customer_id: @c1.id,
                   merchant_id: @m2.id,
                   status: "shipped")

    get :find_all, customer_id: @c1.id, format: :json

    assert_response :success
    assert_equal 4, response_body.count
    assert_equal @m2.id, response_body[1]["merchant_id"]
  end

  test "#find_all with no invoice matches" do
    Invoice.create(customer_id: @c1.id,
                   merchant_id: @m3.id,
                   status: "shipped")
    Invoice.create(customer_id: @i1.id,
                   merchant_id: @m1.id,
                   status: "shipped")

    get :find_all, customer_id: 11011001, format: :json

    assert_response :not_found
  end

  test "#random invoice" do
    Invoice.create(customer_id: @c3.id,
                   merchant_id: @m1.id,
                   status: "shipped")
    Invoice.create(customer_id: @c7.id,
                   merchant_id: @m3.id,
                   status: "shipped")
    Invoice.create(customer_id: @c6.id,
                   merchant_id: @m1.id,
                   status: "shipped")
    Invoice.create(customer_id: @c1.id,
                   merchant_id: @m4.id,
                   status: "shipped")

    get :random, format: :json
    assert_response :success

    assert_includes [@c1.id, @c2.id, @c3.id, @c4.id,@c5.id, @c6.id, @c7.id,
                     @c8.id], response_body["customer_id"]
  end

end
