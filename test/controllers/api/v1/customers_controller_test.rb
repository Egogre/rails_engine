require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase
  test "customer index json api" do
    get :index, format: :json

    assert_response :success
  end

  test "customer index count" do
    customer_count = Customer.count

    get :index, format: :json


    assert_equal customer_count, response_body.count
  end

  test "customer show json api" do
    customer = Customer.create

    get :show, format: :json, id: customer.id

    assert_response :success
  end

  test "customer show gives correct name" do
    customer = Customer.create(first_name: "Test", last_name: "User")

    get :show, format: :json, id: customer.id

    assert_equal "Test", response_body["first_name"]
    assert_equal "User", response_body["last_name"]
  end

  test "404 for non-existant customer" do
    customer = Customer.create(first_name: "Test", last_name: "User")

    get :show, format: :json, id: customer.id + 1

    assert_response :not_found
  end

  test "#find customer" do
    new_customer = Customer.create(first_name: "New", last_name: "Person")

    get :find, id: new_customer.id, format: :json

    assert_response :success
    assert_equal "New", response_body["first_name"]
    assert_equal "Person", response_body["last_name"]

    get :find, first_name: "New", format: :json

    assert_response :success
    assert_equal "New", response_body["first_name"]
    assert_equal "Person", response_body["last_name"]
  end

end
