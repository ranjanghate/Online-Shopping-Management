class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :purchase_items, dependent: :destroy
  has_many :courses, through: :purchase_items

  after_commit :destroy_cart, only: %i(create)

  private
  def destroy_cart
    DestroyCartJob.perform_later(Current.cart)
  end
end
