ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
SimpleCov.start 'rails'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def response_body
    JSON.parse(response.body)
  end

  def create_merchants!
    Merchant.create(name: "Gandalf")
    Merchant.create(name: "Bilbo")
    Merchant.create(name: "Elrond")
    Merchant.create(name: "Gollum")
  end

  # Add more helper methods to be used by all tests here...
end
