class Customer < ActiveRecord::Base
  has_many :transactions, through: :invoices
  has_many :invoices
end
