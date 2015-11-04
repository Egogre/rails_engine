class Customer < ActiveRecord::Base
  extend ApplicationModel
  has_many :transactions, through: :invoices
  has_many :invoices
end
