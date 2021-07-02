class DestroyCartJob < ApplicationJob
  queue_as :default

  def perform(cart)
    cart.cart_items.destroy_all
  end
end
