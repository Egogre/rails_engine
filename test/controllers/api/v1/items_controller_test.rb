require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase

  def item
    Item.create(name: "Test Item",
                description: "Useful",
                unit_price: 9999,
                merchant_id: @m1.id)
  end

  test "item index json api" do
    get :index, format: :json

    assert_response :success
  end

  test "item index count" do
    item_count = Item.count

    get :index, format: :json

    assert_equal item_count, response_body.count
  end

  test "item show json api" do
    get :show, format: :json, id: item.id

    assert_response :success
  end

  test "item show gives correct data" do
    get :show, format: :json, id: item.id

    assert_equal "Test Item", response_body["name"]
    assert_equal "Useful", response_body["description"]
    assert_equal "99.99", response_body["unit_price"]
    assert_equal @m1.id, response_body["merchant_id"]
  end

  test "404 for non-existant item" do
    get :show, format: :json, id: item.id + 1

    assert_response :not_found
  end

  test "#find item" do
    get :find, id: item.id, format: :json

    assert_response :success
    assert_equal "Test Item", response_body["name"]
    assert_equal "Useful", response_body["description"]
    assert_equal "99.99", response_body["unit_price"]
    assert_equal @m1.id, response_body["merchant_id"]

    get :find, description: "Useful", format: :json

    assert_response :success
    assert_equal "Test Item", response_body["name"]
    assert_equal "Useful", response_body["description"]
    assert_equal "99.99", response_body["unit_price"]
    assert_equal @m1.id, response_body["merchant_id"]
  end

  test "#find non-existant item" do
    get :find, id: item.id + 1, format: :json

    assert_response :not_found
  end

  test "#find_all items" do
    Item.create(name: "Test Item",
                description: "Useful",
                unit_price: 9999,
                merchant_id: @m1.id)
    Item.create(name: "Other Test Item",
                description: "Very Useful",
                unit_price: 9999,
                merchant_id: @m1.id)

    get :find_all, unit_price: "9999", format: :json

    assert_response :success
    assert_equal 2, response_body.count
    assert_equal "Other Test Item", response_body[1]["name"]
  end

  test "#find_all with no customer matches" do
    Item.create(name: "Test Item",
                description: "Useful",
                unit_price: 9999,
                merchant_id: @m1.id)
    Item.create(name: "Other Test Item",
                description: "Very Useful",
                unit_price: 9999,
                merchant_id: @m1.id)

    get :find_all, name: "BILLYJOEBOBRAYGUN", format: :json

    assert_response :not_found
  end

  test "#random customer" do
    Item.create(name: "Test Item",
                description: "Useful",
                unit_price: 1234,
                merchant_id: @m1.id)
    Item.create(name: "Other Test Item",
                description: "Very Useful",
                unit_price: 4321,
                merchant_id: @m2.id)
    Item.create(name: "Another Test Item",
                description: "Very Very Useful",
                unit_price: 3456,
                merchant_id: @m3.id)
    Item.create(name: "And Yet Another Test Item",
                description: "Ultra Useful",
                unit_price: 6543,
                merchant_id: @m4.id)

    get :random, format: :json
    assert_response :success

    assert_includes ["12.34", "43.21", "34.56", "65.43",
                     "0.99", "999.99", "10.99", "5.30",
                     "0.01", "10.00", "0.50", "30.00"], response_body["unit_price"]
  end

end
