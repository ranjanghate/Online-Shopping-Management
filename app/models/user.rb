class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable, :confirmable
  has_many :addresses, dependent: :destroy
  belongs_to :default_address, foreign_key: :default_address_id, class_name: 'Address', optional: :true
  has_one :cart, dependent: :destroy
  has_many :cart_items, through: :cart, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :purchase_items, through: :purchases, dependent: :destroy
  has_one_attached :profile_pic

  after_create :add_cart

  validates :first_name, presence: true, length: { minimum: 3 }
  validates :last_name, presence: true, length: { minimum: 3 }
  validates :age, presence: true, numericality: { only_integer: true }
  validates :school, presence: true, length: { minimum: 5 }

  private
  def add_cart
    Cart.create(user_id: self.id)
  end
end
