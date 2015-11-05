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

  test "#find non-existant merchant" do
    get :find, id: merchant.id + 1, format: :json

    assert_response :not_found
  end

  test "#find_all customers" do
    merchant1 = Merchant.create(name: "Test Merchant")
    merchant2 = Merchant.create(name: "Test Merchant")

    get :find_all, name: "Test Merchant", format: :json

    assert_response :success
    assert_equal 2, response_body.count
    assert_equal merchant1.id, response_body[0]["id"]
  end

  test "#find_all with no customer matches" do
    Merchant.create(name: "Test Merchant")
    Merchant.create(name: "Test Merchant")

    get :find_all, name: "Testz Merchantz", format: :json

    assert_response :not_found
  end

  test "#random customer" do
    create_merchants!

    get :random, format: :json
    assert_response :success

    assert_includes ["Gandalf", "Bilbo", "Elrond", "Gollum"], response_body["name"]
  end

  test "#most_revenue returns x top revenue merchants" do
    create_merchants!

  end

end
