require 'csv'

namespace :import_csv_data do
  task :create_tables => :environment do
    CSV.foreach('./data/customers.csv', :headers => true) do |row|
      Customer.create!(row.to_hash)
    end
    CSV.foreach('./data/invoice_items.csv', :headers => true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
    CSV.foreach('./data/invoices.csv', :headers => true) do |row|
      Invoice.create!(row.to_hash)
    end
    CSV.foreach('./data/items.csv', :headers => true) do |row|
      Item.create!(row.to_hash)
    end
    CSV.foreach('./data/merchants.csv', :headers => true) do |row|
      Merchant.create!(row.to_hash)
    end
    CSV.foreach('./data/transactions.csv', :headers => true) do |row|
      Transaction.create!(row.to_hash)
    end
  end
end
