class Address < ApplicationRecord
  belongs_to :user
  has_one :default_address, foreign_key: :default_address_id, class_name: 'User', dependent: :nullify
  has_many :purchases

  validates :street, presence: true, length: { minimum: 5 }
  validates :city, presence: true, length: { minimum: 5 }
  validates :state, presence: true, length: { minimum: 3 }
  validates :country, presence: true, length: { minimum: 3 }
  validates :code, presence: true, numericality: { only_integer: true }, length: { minimum: 5 }
end
