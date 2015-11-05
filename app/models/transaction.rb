class Transaction < ActiveRecord::Base
  extend ApplicationModel
  belongs_to :invoice
  has_many :invoice_items, through: :invoice
  scope :successful, -> { where(result: "success") }
  scope :unsuccessful, -> { where(result: "failed") }
end
