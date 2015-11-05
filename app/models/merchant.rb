class Merchant < ActiveRecord::Base
  extend ApplicationModel
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices

  scope :most_revenue, -> (top_x) {
    select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue").
    joins(:invoice_items).
    group("merchants.id").
    order("revenue DESC").limit(top_x).
    merge(InvoiceItem.paid)
  }

  scope :most_items, -> (top_x) {
    select("merchants.*, sum(invoice_items.quantity) AS items_sold").
    joins(:invoice_items).
    group("merchants.id").
    order("items_sold DESC").limit(top_x).
    merge(InvoiceItem.paid)
  }

  scope :favorite_merchant, -> (customer_id) {
    select("merchants.*, count(transactions.id) AS total_transactions").
    joins(:transactions).
    joins(:customers).
    where("customers.id" => customer_id).
    group("merchants.id").
    order("total_transactions DESC").limit(1).
    merge(Transaction.successful)
  }

  def self.revenue(id, date = nil)
    if date
    InvoiceItem.paid.joins(:invoice)
                .where("invoices.created_at" => date)
                .joins(:merchants).where("merchants.id" => id)
                .sum("quantity * unit_price") / 100.00
    else
    InvoiceItem.paid.joins(:invoice)
                .joins(:merchants).where("merchants.id" => id)
                .sum("quantity * unit_price") / 100.00
    end
  end

  def self.revenue_date(date)
    InvoiceItem.paid.joins(:invoice)
                .where("invoices.created_at" => date)
                .sum("quantity * unit_price") / 100.00
  end

  def self.pending_invoices(id)
    Customer.joins(:invoices)
            .where("invoices.merchant_id" => id)
            .distinct.merge(Invoice.unsuccessful)
  end

end
