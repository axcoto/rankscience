class Company < ApplicationRecord
  validates :name, presence: true

  has_many :products
  has_many :shipments
end
