class InvoiceItem < ActiveRecord::Base
  extend ApplicationModel
  belongs_to :invoice
  belongs_to :item
  has_many :transactions, through: :invoice
  has_many :merchants, through: :invoice

  scope :paid, -> { joins(:transactions).merge(Transaction.successful)}
end
