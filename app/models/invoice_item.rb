class InvoiceItem < ActiveRecord::Base
  extend ApplicationModel
  belongs_to :invoice
  belongs_to :item
end
