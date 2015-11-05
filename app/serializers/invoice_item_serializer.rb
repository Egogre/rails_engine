class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id,
             :item_id,
             :invoice_id,
             :quantity,
             :unit_price,
             :created_at,
             :updated_at

  def unit_price
    '%.2f' % (object.unit_price.to_i / 100.0)
  end
end
