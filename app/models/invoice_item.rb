class InvoiceItem < ActiveRecord::Base
  extend ApplicationModel
  belongs_to :invoice
  belongs_to :item

  before_save :unit_price_to_dollars

  def unit_price_to_dollars
    self.unit_price = '%.2f' % (self.unit_price.to_i / 100.0)
  end
end
