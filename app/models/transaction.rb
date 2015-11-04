class Transaction < ActiveRecord::Base
  extend ApplicationModel
  belongs_to :invoice
end
