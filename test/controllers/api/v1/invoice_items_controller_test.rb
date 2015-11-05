require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase

  def invoice_item
    InvoiceItem.create(item_id: @i1.id,
                       invoice_id: @inv1.id,
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
    assert_equal "30.00", response_body["unit_price"]
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
    assert_equal "30.00", response_body["unit_price"]

    get :find, invoice_id: 1, format: :json

    assert_response :success
    assert_equal 1, response_body["item_id"]
    assert_equal 1, response_body["invoice_id"]
    assert_equal 7, response_body["quantity"]
    assert_equal "30.00", response_body["unit_price"]
  end

  test "#find non-existant invoice_item" do
    get :find, id: invoice_item.id + 1, format: :json

    assert_response :not_found
  end

  test "#find_all invoice_items" do
    InvoiceItem.create(item_id: @i1.id,
                       invoice_id: @inv12.id,
                       quantity: 7,
                       unit_price: 3000)
    InvoiceItem.create(item_id: @i5.id,
                       invoice_id: @inv12.id,
                       quantity: 1,
                       unit_price: 9999)

    get :find_all, invoice_id: @inv12.id, format: :json

    assert_response :success
    assert_equal 2, response_body.count
    assert_equal "30.00", response_body[0]["unit_price"]
  end

  test "#find_all with no customer matches" do
    InvoiceItem.create(item_id: @i1.id,
                       invoice_id: @inv2.id,
                       quantity: 7,
                       unit_price: 3000)
    InvoiceItem.create(item_id: @i5.id,
                       invoice_id: @inv13.id,
                       quantity: 1,
                       unit_price: 9999)

    get :find_all, item_id: 919199, format: :json

    assert_response :not_found
  end

  test "#random customer" do
    InvoiceItem.create(item_id: @i1.id,
                       invoice_id: @inv2.id,
                       quantity: 7,
                       unit_price: 3000)
    InvoiceItem.create(item_id: @i1.id,
                       invoice_id: @inv2.id,
                       quantity: 1,
                       unit_price: 9999)
    InvoiceItem.create(item_id: @i9.id,
                       invoice_id: @inv15.id,
                       quantity: 12,
                       unit_price: 3119)
    InvoiceItem.create(item_id: @i4.id,
                       invoice_id: @inv1.id,
                       quantity: 3,
                       unit_price: 107)

    get :random, format: :json
    assert_response :success

    assert_includes [7, 12, 1, 3], response_body["quantity"]
  end

end
