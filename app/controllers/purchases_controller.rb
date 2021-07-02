class PurchasesController < ApplicationController
  before_action :user_signed_in?
  before_action :authenticate_user!, only: %i(index bill)
  before_action :empty_cart, only: %i(bill, create)

  def index
    @purchases = Current.user.purchases
  end

  def bill
    @total_price = Current.cart.courses.sum(:price)
    @total_items = Current.cart.cart_items.count
    @address = Current.user.default_address
    if @address.nil?
      redirect_to users_path, warning: "Please add a primary address to purchase cart"
    end
  end

  def create
    total_price = Current.cart.courses.sum(:price)
    items = Current.cart.courses.pluck(:id, :price)

    @purchase = Current.user.purchases.create(user_id: Current.user.id, address_id: Current.address.id, total_price: total_price)

    if @purchase.nil?
      redirect_to users_path, warning: "Failed to purchase"
    end

    items.each do |course_id, price|
      purchase_item = PurchaseItem.new(course_id: course_id, price: price, purchase_id: @purchase.id)
      redirect_to users_path, warning: "Failed to complete purchase" unless purchase_item.save
    end
    PurchaseMailJob.perform_later(@purchase, Current.user)
    redirect_to users_path, success: "Purchase succesfully"
  end

  private
  def empty_cart
    redirect_to users_path, warning: "Cannot Purchase a empty cart" if Current.cart.cart_items.count == 0 
  end
end
