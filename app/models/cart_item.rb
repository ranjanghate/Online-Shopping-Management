class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :course
  validates :course_id, uniqueness: { scope: :cart_id, message: "One course per user" }
end
