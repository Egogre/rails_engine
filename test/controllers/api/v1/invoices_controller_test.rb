require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  test "invoice index json api" do
    get :index, format: :json

    assert_response :success
  end

  test "invoice index count" do
    invoice_count = Invoice.count

    get :index, format: :json

    response_body = JSON.parse(response.body)

    assert_equal invoice_count, response_body.count
  end

  test "invoice show json api" do
    invoice = Invoice.create

    get :show, format: :json, id: invoice.id

    assert_response :success
  end
end
