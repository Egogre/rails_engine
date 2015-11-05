class Customer < ActiveRecord::Base
  extend ApplicationModel
  has_many :transactions, through: :invoices
  has_many :invoices
  has_many :merchants, through: :invoices

  def self.favorite_customer(merch_id)
    select("customers.*, count(transactions.id) AS transactions_count")
    .joins(:transactions) .where("transactions.result" => "success")
    .joins(:merchants) .where("merchants.id" => merch_id)
    .group("customers.id")
    .order("transactions_count DESC").limit(1)
  end
end
