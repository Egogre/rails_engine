class Customer < ActiveRecord::Base
  has_many :transactions, through: :invoices
  has_many :invoices


  def self.random
    order("random()").first
  end
end
