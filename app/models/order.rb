class Order < ApplicationRecord

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { awaiting_payment: 0, payment_confirmation: 1, production: 2, shipping_preparation: 3, shipped: 4 }

  has_many :order_details, dependent: :destroy
  belongs_to :customer

end