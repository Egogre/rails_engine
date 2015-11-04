require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase

  def invoice_item
    InvoiceItem.create(item_id: 1,
                       invoice_id: 1,
                       quantity: 7,
                       unit_price: 3000)
  end

  test "invoice items index json api" do
    get :index, format: :json

    assert_response :success
  end

  test "invoice items index count" do
    invoice_items_count = InvoiceItem.count

    get :index, format: :json

    assert_equal invoice_items_count, response_body.count
  end

  test "invoice items show json api" do
    get :show, format: :json, id: invoice_item.id

    assert_response :success
  end

  test "invoice_item show gives correct data" do
    get :show, format: :json, id: invoice_item.id

    assert_equal 1, response_body["item_id"]
    assert_equal 1, response_body["invoice_id"]
    assert_equal 7, response_body["quantity"]
    assert_equal 3000, response_body["unit_price"]
  end

  test "404 for non-existant invoice_item" do
    get :show, format: :json, id: invoice_item.id + 1

    assert_response :not_found
  end

  test "#find invoice_item" do
    get :find, id: invoice_item.id, format: :json

    assert_response :success
    assert_equal 1, response_body["item_id"]
    assert_equal 1, response_body["invoice_id"]
    assert_equal 7, response_body["quantity"]
    assert_equal 3000, response_body["unit_price"]

    get :find, invoice_id: 1, format: :json

    assert_response :success
    assert_equal 1, response_body["item_id"]
    assert_equal 1, response_body["invoice_id"]
    assert_equal 7, response_body["quantity"]
    assert_equal 3000, response_body["unit_price"]
  end

end
