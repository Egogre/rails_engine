require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase

  def customer
    Customer.create(first_name: "Test", last_name: "User")
  end

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
    get :show, format: :json, id: customer.id

    assert_response :success
  end

  test "customer show gives correct name" do
    get :show, format: :json, id: customer.id

    assert_equal "Test", response_body["first_name"]
    assert_equal "User", response_body["last_name"]
  end

  test "404 for non-existant customer" do
    get :show, format: :json, id: customer.id + 1

    assert_response :not_found
  end

  test "#find customer" do
    get :find, id: customer.id, format: :json

    assert_response :success
    assert_equal "Test", response_body["first_name"]

    get :find, first_name: "Test", format: :json

    assert_response :success
    assert_equal "User", response_body["last_name"]
  end

  test "#find non-existant customer" do
    get :find, id: customer.id + 1, format: :json

    assert_response :not_found
  end

  test "#find_all customers" do
    skip
    Customer.create(first_name: "John", last_name: "Doe")
    Customer.create(first_name: "John", last_name: "Notdoe")

    get :find_all, first_name: "Test", format: :json

    assert_response :success
    assert_equal 2, response_body.count
    assert_equal "Doe", response_body[0].last_name
  end

  test "#random customer" do
    Customer.create(first_name: "John", last_name: "Doe")
    Customer.create(first_name: "John", last_name: "Notdoe")
    Customer.create(first_name: "Notjohn", last_name: "Notdoe")

    get :random, format: :json
    assert_response :success

    assert_includes ["John", "Notjohn"], response_body["first_name"]
  end

end
