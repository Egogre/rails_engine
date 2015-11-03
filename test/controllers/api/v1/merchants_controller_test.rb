require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase

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
    merchant = Merchant.create

    get :show, format: :json, id: merchant.id

    assert_response :success
  end

  test "merchant show gives correct name" do
    merchant = Merchant.create(name: "Test Merchant")

    get :show, format: :json, id: merchant.id

    assert_equal "Test Merchant", response_body["name"]
  end

  test "404 for non-existant merchant" do
    merchant = Merchant.create(name: "Test Merchant")

    get :show, format: :json, id: merchant.id + 1

    assert_response :not_found
  end

end
