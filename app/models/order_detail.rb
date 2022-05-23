class OrderDetail < ApplicationRecord

  enum status: { production_cannot: 0, awaiting_manufacture: 1, in_production: 2, completed_production: 3 }

  belongs_to :item
  belongs_to :order
end
