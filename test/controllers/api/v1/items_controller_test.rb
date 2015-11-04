require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase

  def item
    Item.create(name: "Test Item",
                description: "Useful",
                unit_price: 9999,
                merchant_id: 1)
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
    assert_equal 9999, response_body["unit_price"]
    assert_equal 1, response_body["merchant_id"]
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
    assert_equal 9999, response_body["unit_price"]
    assert_equal 1, response_body["merchant_id"]

    get :find, description: "Useful", format: :json

    assert_response :success
    assert_equal "Test Item", response_body["name"]
    assert_equal "Useful", response_body["description"]
    assert_equal 9999, response_body["unit_price"]
    assert_equal 1, response_body["merchant_id"]
  end

  test "#find non-existant item" do
    get :find, id: item.id + 1, format: :json

    assert_response :not_found
  end

end
