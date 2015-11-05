ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
SimpleCov.start 'rails'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'database_cleaner'

class ActiveSupport::TestCase

  def setup
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
    travel_to Time.utc(2004, 11, 24, 01, 04, 44) do
      create_sample_data!
    end
  end

  def teardown
    DatabaseCleaner.clean
  end

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
    @m1 = Merchant.create(name: "Gandalf")
    @m2 = Merchant.create(name: "Bilbo")
    @m3 = Merchant.create(name: "Elrond")
    @m4 = Merchant.create(name: "Gollum")
  end

  def create_customers!
    @c1 = Customer.create(first_name: "Frodo", last_name: "Baggins")
    @c2 = Customer.create(first_name: "Legolas", last_name: "Elf")
    @c3 = Customer.create(first_name: "Aaragorn", last_name: "King")
    @c4 = Customer.create(first_name: "Merryweather", last_name: "Took")
    @c5 = Customer.create(first_name: "Pippin", last_name: "Took")
    @c6 = Customer.create(first_name: "Samwise", last_name: "Gamgee")
    @c7 = Customer.create(first_name: "Gimli", last_name: "Dwarf")
    @c8 = Customer.create(first_name: "Boromir", last_name: "Traitor")
  end

  def create_items!
    @i1 = Item.create(name: "White Robes",
                merchant_id: @m1.id,
                description: "No longer grey",
                unit_price: 99)
    @i2 = Item.create(name: "Glamdring",
                merchant_id: @m1.id,
                description: "Magic Sword",
                unit_price: 99999)
    @i3 = Item.create(name: "There and Back Again",
                merchant_id: @m2.id,
                description: "An Unexpected Journey",
                unit_price: 1099)
    @i4 = Item.create(name: "Pipe and Tabac",
                merchant_id: @m2.id,
                description: "To Rule Them All",
                unit_price: 530)
    @i5 = Item.create(name: "Map",
                merchant_id: @m3.id,
                description: "Find the back door",
                unit_price: 3000)
    @i6 = Item.create(name: "Wisdom",
                merchant_id: @m3.id,
                description: "No one listens anyway",
                unit_price: 1)
    @i7 = Item.create(name: "Arwen",
                merchant_id: @m3.id,
                description: "Wilfull Daughter also won't listen",
                unit_price: 50)
    @i8 = Item.create(name: "Frodo's Finger",
                merchant_id: @m4.id,
                description: "A 'handy' souvenier",
                unit_price: 1000)
    @i9 = Item.create(name: "The One Ring",
                merchant_id: @m4.id,
                description: "To Rule Them All",
                unit_price: 1)
  end

  def create_invoices!
    @inv1 = Invoice.create(customer_id: @c1.id,
                   merchant_id: @m1.id,
                   status: "shipped")
    @inv2 = Invoice.create(customer_id: @c2.id,
                   merchant_id: @m2.id,
                   status: "shipped")
    @inv3 = Invoice.create(customer_id: @c3.id,
                   merchant_id: @m3.id,
                   status: "shipped")
    @inv4 = Invoice.create(customer_id: @c4.id,
                   merchant_id: @m4.id,
                   status: "shipped")
    @inv5 = Invoice.create(customer_id: @c5.id,
                   merchant_id: @m3.id,
                   status: "shipped")
    @inv6 = Invoice.create(customer_id: @c6.id,
                   merchant_id: @m4.id,
                   status: "shipped")
    @inv7 = Invoice.create(customer_id: @c7.id,
                   merchant_id: @m1.id,
                   status: "shipped")
    @inv8 = Invoice.create(customer_id: @c8.id,
                   merchant_id: @m1.id,
                   status: "shipped")
    @inv9 = Invoice.create(customer_id: @c1.id,
                   merchant_id: @m2.id,
                   status: "shipped")
    @inv10 = Invoice.create(customer_id: @c2.id,
                   merchant_id: @m3.id,
                   status: "shipped")
    @inv11 = Invoice.create(customer_id: @c3.id,
                   merchant_id: @m3,
                   status: "shipped")
    @inv12 = Invoice.create(customer_id: @c4.id,
                   merchant_id: @m2.id,
                   status: "shipped")
    @inv13 = Invoice.create(customer_id: @c5.id,
                   merchant_id: @m1.id,
                   status: "shipped")
    @inv14 = Invoice.create(customer_id: @c6.id,
                   merchant_id: @m4.id,
                   status: "shipped")
    @inv15 = Invoice.create(customer_id: @c7.id,
                   merchant_id: @m4.id,
                   status: "shipped")
    @inv16 = Invoice.create(customer_id: @c8.id,
                   merchant_id: @m2.id,
                   status: "shipped")
    @inv17 = Invoice.create(customer_id: @c2.id,
                   merchant_id: @m2.id,
                   status: "shipped")
    @inv18 = Invoice.create(customer_id: @c4.id,
                   merchant_id: @m2.id,
                   status: "shipped")
    @inv19 = Invoice.create(customer_id: @c7.id,
                   merchant_id: @m2.id,
                   status: "shipped")
    @inv20 = Invoice.create(customer_id: @c7.id,
                   merchant_id: @m4.id,
                   status: "shipped")
  end

  def create_invoice_items!
    InvoiceItem.create(item_id: @i1.id,
                       invoice_id: @inv1.id,
                       quantity: 1,
                       unit_price: 99)
    InvoiceItem.create(item_id: @i2.id,
                       invoice_id: @inv1.id,
                       quantity: 5,
                       unit_price: 99999)
    InvoiceItem.create(item_id: @i3.id,
                       invoice_id: @inv2.id,
                       quantity: 21,
                       unit_price: 1099)
    InvoiceItem.create(item_id: @i4.id,
                       invoice_id: @inv2.id,
                       quantity: 1,
                       unit_price: 530)
    InvoiceItem.create(item_id: @i5.id,
                       invoice_id: @inv3.id,
                       quantity: 7,
                       unit_price: 3000)
    InvoiceItem.create(item_id: @i6.id,
                       invoice_id: @inv3.id,
                       quantity: 4,
                       unit_price: 1)
    InvoiceItem.create(item_id: @i8.id,
                       invoice_id: @inv4.id,
                       quantity: 9,
                       unit_price: 1)
    InvoiceItem.create(item_id: @i5.id,
                       invoice_id: @inv5.id,
                       quantity: 11,
                       unit_price: 3000)
    InvoiceItem.create(item_id: @i6.id,
                       invoice_id: @inv5.id,
                       quantity: 1,
                       unit_price: 1)
    InvoiceItem.create(item_id: @i7.id,
                       invoice_id: @inv5.id,
                       quantity: 9,
                       unit_price: 50)
    InvoiceItem.create(item_id: @i8.id,
                       invoice_id: @inv6.id,
                       quantity: 4,
                       unit_price: 1)
    InvoiceItem.create(item_id: @i9.id,
                       invoice_id: @inv6.id,
                       quantity: 2,
                       unit_price: 1000)
    InvoiceItem.create(item_id: @i1.id,
                       invoice_id: @inv7.id,
                       quantity: 3,
                       unit_price: 99)
    InvoiceItem.create(item_id: @i1.id,
                       invoice_id: @inv8.id,
                       quantity: 1,
                       unit_price: 99)
    InvoiceItem.create(item_id: @i4.id,
                       invoice_id: @inv9.id,
                       quantity: 5,
                       unit_price: 530)
    InvoiceItem.create(item_id: @i6.id,
                       invoice_id: @inv10.id,
                       quantity: 10,
                       unit_price: 1)
    InvoiceItem.create(item_id: @i7.id,
                       invoice_id: @inv10.id,
                       quantity: 1,
                       unit_price: 50)
    InvoiceItem.create(item_id: @i3.id,
                       invoice_id: @inv11.id,
                       quantity: 1,
                       unit_price: 1099)
    InvoiceItem.create(item_id: @i4.id,
                       invoice_id: @inv12.id,
                       quantity: 13,
                       unit_price: 530)
    InvoiceItem.create(item_id: @i1.id,
                       invoice_id: @inv13.id,
                       quantity: 1,
                       unit_price: 99)
    InvoiceItem.create(item_id: @i2.id,
                       invoice_id: @inv13.id,
                       quantity: 9,
                       unit_price: 99999)
    InvoiceItem.create(item_id: @i9.id,
                       invoice_id: @inv14.id,
                       quantity: 20,
                       unit_price: 1000)
    InvoiceItem.create(item_id: @i8.id,
                       invoice_id: @inv15.id,
                       quantity: 1,
                       unit_price: 1)
    InvoiceItem.create(item_id: @i3.id,
                       invoice_id: @inv16.id,
                       quantity: 7,
                       unit_price: 1099)
    InvoiceItem.create(item_id: @i3.id,
                       invoice_id: @inv17.id,
                       quantity: 1,
                       unit_price: 1099)
    InvoiceItem.create(item_id: @i4.id,
                       invoice_id: @inv18.id,
                       quantity: 1,
                       unit_price: 530)
    InvoiceItem.create(item_id: @i3.id,
                       invoice_id: @inv19.id,
                       quantity: 99,
                       unit_price: 1099)
    InvoiceItem.create(item_id: @i4.id,
                       invoice_id: @inv19.id,
                       quantity: 31,
                       unit_price: 530)
    InvoiceItem.create(item_id: @i8.id,
                       invoice_id: @inv20.id,
                       quantity: 1,
                       unit_price: 1)

  end

  def create_transactions!
    Transaction.create(invoice_id: @inv1.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: @inv2.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "failed")
    Transaction.create(invoice_id: @inv2.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: @inv3.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: @inv4.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: @inv5.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "failed")
    Transaction.create(invoice_id: @inv5.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "failed")
    Transaction.create(invoice_id: @inv5.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "failed")
    Transaction.create(invoice_id: @inv6.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: @inv7.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: @inv8.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: @inv9.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "failed")
    Transaction.create(invoice_id: @inv10.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: @inv11.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: @inv12.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: @inv13.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "failed")
    Transaction.create(invoice_id: @inv13.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: @inv14.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: @inv15.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: @inv16.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: @inv17.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "failed")
    Transaction.create(invoice_id: @inv18.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: @inv19.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
    Transaction.create(invoice_id: @inv20.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "failed")
    Transaction.create(invoice_id: @inv20.id,
                       credit_card_number: "1234123412341234",
                       credit_card_expiration_date: "NEVER!",
                       result: "success")
  end

end
