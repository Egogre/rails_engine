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

  def create_sample_data!
    create_merchants!
    create_customers!
    create_items!
    create_invoices!
    create_invoice_items!
    create_transactions!
  end

  def create_merchants!
    Merchant.create(name: "Gandalf")
    Merchant.create(name: "Bilbo")
    Merchant.create(name: "Elrond")
    Merchant.create(name: "Gollum")
  end

  def create_customers!
    Customer.create(first_name: "Frodo", last_name: "Baggins")
    Customer.create(first_name: "Legolas", last_name: "Elf")
    Customer.create(first_name: "Aaragorn", last_name: "King")
    Customer.create(first_name: "Merryweather", last_name: "Took")
    Customer.create(first_name: "Pippin", last_name: "Took")
    Customer.create(first_name: "Samwise", last_name: "Gamgee")
    Customer.create(first_name: "Gimli", last_name: "Dwarf")
    Customer.create(first_name: "Boromir", last_name: "Traitor")
  end

  def create_items!
    Item.create(name: "White Robes",
                merchant_id: 1,
                description: "No longer grey",
                unit_price: 99)
    Item.create(name: "Glamdring",
                merchant_id: 1,
                description: "Magic Sword",
                unit_price: 99999)
    Item.create(name: "There and Back Again",
                merchant_id: 2,
                description: "An Unexpected Journey",
                unit_price: 1099)
    Item.create(name: "Pipe and Tabac",
                merchant_id: 2,
                description: "To Rule Them All",
                unit_price: 530)
    Item.create(name: "Map",
                merchant_id: 3,
                description: "Find the back door",
                unit_price: 3000)
    Item.create(name: "Wisdom",
                merchant_id: 3,
                description: "No one listens anyway",
                unit_price: 1)
    Item.create(name: "Arwen",
                merchant_id: 3,
                description: "Wilfull Daughter also won't listen",
                unit_price: 50)
    Item.create(name: "Frodo's Finger",
                merchant_id: 4,
                description: "A 'handy' souvenier",
                unit_price: 1000)
    Item.create(name: "The One Ring",
                merchant_id: 4,
                description: "To Rule Them All",
                unit_price: 1)
  end

  def create_invoices!
    Invoice.create(customer_id: 1,
                   merchant_id: 1,
                   status: "shipped")
    Invoice.create(customer_id: 2,
                   merchant_id: 1,
                   status: "shipped")
    Invoice.create(customer_id: 3,
                   merchant_id: 1,
                   status: "shipped")
    Invoice.create(customer_id: 4,
                   merchant_id: 1,
                   status: "shipped")
    Invoice.create(customer_id: 5,
                   merchant_id: 1,
                   status: "shipped")
    Invoice.create(customer_id: 6,
                   merchant_id: 1,
                   status: "shipped")
    Invoice.create(customer_id: 7,
                   merchant_id: 1,
                   status: "shipped")
    Invoice.create(customer_id: 8,
                   merchant_id: 1,
                   status: "shipped")
    Invoice.create(customer_id: 1,
                   merchant_id: 1,
                   status: "shipped")
    Invoice.create(customer_id: 2,
                   merchant_id: 1,
                   status: "shipped")
    Invoice.create(customer_id: 3,
                   merchant_id: 1,
                   status: "shipped")
    Invoice.create(customer_id: 4,
                   merchant_id: 1,
                   status: "shipped")
    Invoice.create(customer_id: 5,
                   merchant_id: 1,
                   status: "shipped")
    Invoice.create(customer_id: 6,
                   merchant_id: 1,
                   status: "shipped")
    Invoice.create(customer_id: 7,
                   merchant_id: 1,
                   status: "shipped")
    Invoice.create(customer_id: 8,
                   merchant_id: 1,
                   status: "shipped")
    Invoice.create(customer_id: 2,
                   merchant_id: 1,
                   status: "shipped")
    Invoice.create(customer_id: 4,
                   merchant_id: 1,
                   status: "shipped")
    Invoice.create(customer_id: 7,
                   merchant_id: 1,
                   status: "shipped")
    Invoice.create(customer_id: 7,
                   merchant_id: 1,
                   status: "shipped")
  end

  def create_invoice_items!
    InvoiceItem.create(item_id: 1,
                       invoice_id: 1,
                       quantity: 1,
                       unit_price: 99)
    InvoiceItem.create(item_id: 2,
                       invoice_id: 1,
                       quantity: 5,
                       unit_price: 99999)
    InvoiceItem.create(item_id: 3,
                       invoice_id: 2,
                       quantity: 21,
                       unit_price: 1099)
    InvoiceItem.create(item_id: 4,
                       invoice_id: 2,
                       quantity: 1,
                       unit_price: 530)
    InvoiceItem.create(item_id: 5,
                       invoice_id: 3,
                       quantity: 7,
                       unit_price: 3000)
    InvoiceItem.create(item_id: 6,
                       invoice_id: 3,
                       quantity: 4,
                       unit_price: 1)
    InvoiceItem.create(item_id: 8,
                       invoice_id: 4,
                       quantity: 9,
                       unit_price: 1)
    InvoiceItem.create(item_id: 5,
                       invoice_id: 5,
                       quantity: 11,
                       unit_price: 3000)
    InvoiceItem.create(item_id: 6,
                       invoice_id: 5,
                       quantity: 1,
                       unit_price: 1)
    InvoiceItem.create(item_id: 7,
                       invoice_id: 5,
                       quantity: 9,
                       unit_price: 50)
    InvoiceItem.create(item_id: 8,
                       invoice_id: 6,
                       quantity: 4,
                       unit_price: 1)
    InvoiceItem.create(item_id: 9,
                       invoice_id: 6,
                       quantity: 2,
                       unit_price: 1000)
    InvoiceItem.create(item_id: 1,
                       invoice_id: 7,
                       quantity: 3,
                       unit_price: 99)
    InvoiceItem.create(item_id: 1,
                       invoice_id: 8,
                       quantity: 1,
                       unit_price: 99)
    InvoiceItem.create(item_id: 4,
                       invoice_id: 9,
                       quantity: 5,
                       unit_price: 530)
    InvoiceItem.create(item_id: 6,
                       invoice_id: 10,
                       quantity: 10,
                       unit_price: 1)
    InvoiceItem.create(item_id: 7,
                       invoice_id: 10,
                       quantity: 1,
                       unit_price: 50)
    InvoiceItem.create(item_id: 3,
                       invoice_id: 11,
                       quantity: 1,
                       unit_price: 1099)
    InvoiceItem.create(item_id: 4,
                       invoice_id: 12,
                       quantity: 13,
                       unit_price: 530)
    InvoiceItem.create(item_id: 1,
                       invoice_id: 13,
                       quantity: 1,
                       unit_price: 99)
    InvoiceItem.create(item_id: 2,
                       invoice_id: 13,
                       quantity: 9,
                       unit_price: 99999)
    InvoiceItem.create(item_id: 9,
                       invoice_id: 14,
                       quantity: 20,
                       unit_price: 1000)
    InvoiceItem.create(item_id: 8,
                       invoice_id: 15,
                       quantity: 1,
                       unit_price: 1)
    InvoiceItem.create(item_id: 3,
                       invoice_id: 16,
                       quantity: 7,
                       unit_price: 1099)
    InvoiceItem.create(item_id: 3,
                       invoice_id: 17,
                       quantity: 1,
                       unit_price: 1099)
    InvoiceItem.create(item_id: 4,
                       invoice_id: 18,
                       quantity: 1,
                       unit_price: 530)
    InvoiceItem.create(item_id: 3,
                       invoice_id: 19,
                       quantity: 99,
                       unit_price: 1099)
    InvoiceItem.create(item_id: 4,
                       invoice_id: 19,
                       quantity: 31,
                       unit_price: 530)
    InvoiceItem.create(item_id: 8,
                       invoice_id: 20,
                       quantity: 1,
                       unit_price: 1)

  end

  def create_transactions!
    Transaction.create(invoice_id: 1,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: 2,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "failed")
    Transaction.create(invoice_id: 2,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: 3,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: 4,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: 5,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "failed")
    Transaction.create(invoice_id: 5,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "failed")
    Transaction.create(invoice_id: 5,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "failed")
    Transaction.create(invoice_id: 6,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: 7,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: 8,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: 9,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "failed")
    Transaction.create(invoice_id: 10,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: 11,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: 12,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: 13,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "failed")
    Transaction.create(invoice_id: 13,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: 14,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: 15,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: 16,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: 17,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "failed")
    Transaction.create(invoice_id: 18,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: 19,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: 20,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "failed")
    Transaction.create(invoice_id: 20,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
  end

end
