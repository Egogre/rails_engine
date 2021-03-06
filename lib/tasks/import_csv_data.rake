require 'csv'

namespace :import_csv_data do
  task :create_tables => :environment do
    file = File.read('data/merchants.csv')
  csv = CSV.parse(file, :headers => true)
  csv.each do |row|
      Merchant.create!(row.to_hash)
  end


  file = File.read('data/items.csv')
  csv = CSV.parse(file, :headers => true)
  csv.each do |row|
      Item.create!(row.to_hash)
  end

  file = File.read('data/customers.csv')
  csv = CSV.parse(file, :headers => true)
  csv.each do |row|
      Customer.create!(row.to_hash)
  end

  file = File.read('data/invoices.csv')
  csv = CSV.parse(file, :headers => true)
  csv.each do |row|
      Invoice.create!(row.to_hash)
  end

  file = File.read('data/invoice_items.csv')
  csv = CSV.parse(file, :headers => true)
  csv.each do |row|
      InvoiceItem.create!(row.to_hash)
  end

  file = File.read('data/transactions.csv')
  csv = CSV.parse(file, :headers => true)
  csv.each do |row|
      Transaction.create!(row.to_hash)
  end
  end
end
