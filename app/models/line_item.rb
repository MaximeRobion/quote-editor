class LineItem < ApplicationRecord
  belongs_to :line_item_date


  validates :name, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than: 0 }

  delegate :quote, to: :line_item_date 
  # that way, one can have access more easily to quote object from here
  # line_item.quote instead of line_item.line_item_date.quote

  def total_price
    quantity * unit_price
  end
end
