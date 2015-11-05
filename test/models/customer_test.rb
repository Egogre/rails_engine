require 'test_helper'

class CustomerTest < ActiveSupport::TestCase

  test "valid customer with attributes" do
    customer = Customer.new(first_name: "Sauron", last_name: "Evil")

    assert customer.valid?
  end

end
