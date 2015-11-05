class Item < ActiveRecord::Base
  extend ApplicationModel
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  before_save :unit_price_to_dollars

  def unit_price_to_dollars
    self.unit_price = '%.2f' % (self.unit_price.to_i / 100.0)
  end
end
