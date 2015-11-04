require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase

  def merchant
    Merchant.create(name: "Test Merchant")
  end

  test "merchant index json api" do
    get :index, format: :json

    assert_response :success
  end

  test "merchant index count" do
    merchant_count = Merchant.count

    get :index, format: :json

    assert_equal merchant_count, response_body.count
  end

  test "merchant show json api" do
    get :show, format: :json, id: merchant.id

    assert_response :success
  end

  test "merchant show gives correct name" do
    get :show, format: :json, id: merchant.id

    assert_equal "Test Merchant", response_body["name"]
  end

  test "404 for non-existant merchant" do
    get :show, format: :json, id: merchant.id + 1

    assert_response :not_found
  end

  test "#find merchant" do
    get :find, id: merchant.id, format: :json

    assert_response :success
    assert_equal "Test Merchant", response_body["name"]

    get :find, name: "Test Merchant", format: :json

    assert_response :success
    assert_equal "Test Merchant", response_body["name"]
  end

end
