class Shipment < ApplicationRecord
  belongs_to :company

  has_many :shipment_products
  has_many :products, through: :shipment_products
end
