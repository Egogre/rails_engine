class Invoice < ActiveRecord::Base
  extend ApplicationModel
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  scope :unsuccessful, -> { joins(:transactions).merge(Transaction.unsuccessful)}
end
