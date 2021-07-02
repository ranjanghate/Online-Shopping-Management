class Course < ApplicationRecord
  has_many_attached :contents
  has_many :cart_items, dependent: :destroy
  has_many :purchase_items, dependent: :destroy

  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 15 }
  validates :price, presence: true
end
