class Item < ActiveRecord::Base
  extend ApplicationModel
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity)
    select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue").
    joins(:invoice_items).
    group("items.id").
    order("revenue DESC").limit(quantity).merge(InvoiceItem.paid)
  end

  def self.most_revenue(quantity)
    select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue").
    joins(:invoice_items).
    group("items.id").
    order("revenue DESC").limit(quantity).merge(InvoiceItem.paid)
  end

  def self.most_items(quantity)
    select("items.*, count(invoice_items.id) AS sold_count").
    joins(:invoice_items).uniq.merge(InvoiceItem.paid).
    group("items.id").
    order("sold_count DESC").limit(quantity)
  end

  def self.best_day(id)
    InvoiceItem.paid.where(item_id: id)
    .group("invoices.created_at")
    .order("sum_quantity DESC")
    .sum("quantity").first[0]
  end
end
