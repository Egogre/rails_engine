class Merchant < ActiveRecord::Base
  extend ApplicationModel
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
end
