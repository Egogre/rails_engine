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

  test "#create customer" do
    new_customer = { first_name: "New", last_name: "Person"}

    post :create, format: :json, customer: new_customer

    assert_response :created
  end

  test "#update customer" do
    customer = Customer.create(first_name: "Test", last_name: "User")
    updated_params = {first_name: "Updated", last_name: "Person"}

    put :update, format: :json, id: customer.id, customer: updated_params

    assert_response :no_content
  end
end
